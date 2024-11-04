import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';

class SaveUserUsecase implements UseCase<bool, UserEntity?> {
  final AuthRepositoryInterface authRepositoryInterface;

  SaveUserUsecase({required this.authRepositoryInterface});
  @override
  Future<bool> call({UserEntity? params}) async {
    return await authRepositoryInterface.authRegisterWithEmail(
      userEntity: params,
    );
  }
}
