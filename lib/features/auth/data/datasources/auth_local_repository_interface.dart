import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sqflite/sqflite.dart';

abstract class AuthLocalRepositoryInterface {
  Future<Database> initialSqfliteAuth();
  Future<bool> registerLocalUser({UserEntity? userEntity});
  Future<bool> loginLocalUser({UserEntity? userEntity});
  String hashPassword(String password);
  Future<AuthStatus> getAuthStatus();
  AuthStatus convertSharedEnum(String authStatus);
   
}
