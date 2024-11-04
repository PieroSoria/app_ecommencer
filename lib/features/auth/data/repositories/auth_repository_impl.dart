import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_interface.dart';
import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthLocalRepositoryInterface authLocalRepositoryInterface;

  AuthRepositoryImpl({required this.authLocalRepositoryInterface});
  @override
  Future<String?> authLoginWithEmail({UserEntity? userEntity}) async {
    return await authLocalRepositoryInterface.loginLocalUser(
      userEntity: userEntity,
    );
  }

  @override
  Future<bool> authRegisterWithEmail({UserEntity? userEntity}) async {
    return await authLocalRepositoryInterface.registerLocalUser(
      userEntity: userEntity,
    );
  }

  @override
  Future<AuthStatus> getverifyAuthStatus() {
    // TODO: implement getverifyAuthStatus
    throw UnimplementedError();
  }
}
