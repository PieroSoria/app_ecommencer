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
import 'package:sqflite_common/sqlite_api.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepositoryInterface {
  @override
  Future<Database> initialSqfliteAuth() async {
    final path = await getDatabasesPath();
    final pathio = join(path, 'product.db');
    final mydb = await openDatabase(
      pathio,
      onCreate: (db, version) {
        db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    lastname TEXT,
    email TEXT,
    password TEXT,
    photo_url TEXT,
    token TEXT,
    fcm_token TEXT
  )
''');
      },
      version: 1,
    );
    return mydb;
  }

  @override
  Future<bool> loginLocalUser({UserEntity? userEntity}) async {
    final mydb = await initialSqfliteAuth();
    final body = UserModel.fromEntity(userEntity!);
    try {
      final passwordCrip = hashPassword(body.password);
      final data = await mydb.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [body.email, passwordCrip],
      );
      return data.isNotEmpty;
    } catch (e) {
      debugPrint("el error en el login es $e");
      return false;
    }
  }

  @override
  Future<bool> registerLocalUser({UserEntity? userEntity}) async {
    final mydb = await initialSqfliteAuth();
    try {
      final body = UserModel.fromEntity(userEntity!);
      final bodymodi = body.toJson().update(
        "password",
        (value) {
          final crip = hashPassword(value.toString());
          return crip;
        },
      );
      final data = await mydb.insert('users', bodymodi);
      return data > 0;
    } catch (e) {
      debugPrint("El error a registrar el user => $e");
      return false;
    }
  }

  @override
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
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
      "AuthStatus.authenticated" => AuthStatus.authenticated,
      "AuthStatus.unauthenticated" => AuthStatus.unauthenticated,
      "AuthStatus.authenticating" => AuthStatus.authenticating,
      "AuthStatus.authenticatedFailed" => AuthStatus.authenticatedFailed,
      "AuthStatus.logOut" => AuthStatus.logOut,
      _ => AuthStatus.unauthenticated,
    };
  }
}
