import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';

class GetTokenUsecase implements UseCase<String?, UserEntity> {
  final AuthRepositoryInterface authRepositoryInterface;

  GetTokenUsecase({required this.authRepositoryInterface});
  @override
  Future<String?> call({UserEntity? params}) async {
    return authRepositoryInterface.authLoginWithEmail(userEntity: params);
  }
}
