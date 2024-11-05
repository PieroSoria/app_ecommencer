import 'dart:convert';

import 'package:app_ecommencer/core/constants/app_constants.dart';
import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_interface.dart';
import 'package:app_ecommencer/features/auth/data/models/user_model.dart';
import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepositoryInterface {
  final Database mydb;

  AuthLocalRepositoryImpl({required this.mydb});

  @override
  Future<String?> loginLocalUser({UserEntity? userEntity}) async {
    final body = UserModel.fromEntity(userEntity!);
    try {
      final passwordCrip = UserModel.hashPassword(body.password);
      final data = await mydb.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [body.email, passwordCrip],
      ).then((result) => result.first);

      return data['email'] != null
          ? UserModel.generateToken(data['email'].toString())
          : null;
    } catch (e) {
      debugPrint("el error en el login es $e");
      return null;
    }
  }

  @override
  Future<bool> registerLocalUser({UserEntity? userEntity}) async {
    try {
      final body = UserModel.fromEntity(userEntity!);
      final bodymodi = body.toJson();

      final data = await mydb.insert('users', bodymodi);
      return data > 0;
    } catch (e) {
      debugPrint("El error a registrar el user => $e");
      return false;
    }
  }

  @override
  Future<AuthStatus> getAuthStatus() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(AppConstants.authstatus) ?? "";
    return convertSharedEnum(data);
  }

  @override
  AuthStatus convertSharedEnum(String authStatus) {
    return switch (authStatus) {
      "authenticated" => AuthStatus.authenticated,
      "unauthenticated" => AuthStatus.unauthenticated,
      "authenticating" => AuthStatus.authenticating,
      "authenticatedFailed" => AuthStatus.authenticatedFailed,
      "logOut" => AuthStatus.logOut,
      _ => AuthStatus.unauthenticated,
    };
  }

  @override
  Future<UserEntity?> getUserWithEmail({String? email}) async {
    try {
      final user = await mydb
          .query(
            'users',
            where: 'email = ?',
            whereArgs: [email],
          )
          .then((data) => data.first)
          .then((value) => UserModel.fromJson(value));
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveAuthStatus({required String authStatus}) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstants.authstatus, authStatus);
  }
}
