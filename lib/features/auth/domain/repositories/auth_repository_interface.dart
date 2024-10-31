import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';

abstract class AuthRepositoryInterface {
  Future<bool> authLoginWithEmail({UserEntity? userEntity});
  Future<AuthStatus> getverifyAuthStatus();
  Future<bool> authRegisterWithEmail({UserEntity? userEntity});
}
