import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sqflite/sqflite.dart';

abstract class AuthLocalRepositoryInterface {
  
  Future<bool> registerLocalUser({UserEntity? userEntity});
  Future<String?> loginLocalUser({UserEntity? userEntity});
  Future<UserEntity?> getUserWithEmail({String email});
  Future<AuthStatus> getAuthStatus();
  Future<void> saveAuthStatus({required String authStatus});
  AuthStatus convertSharedEnum(String authStatus);
}
