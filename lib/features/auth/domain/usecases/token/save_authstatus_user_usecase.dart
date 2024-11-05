import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';

class SaveAuthstatusUserUsecase implements UseCase<void, String> {
  final AuthRepositoryInterface authRepositoryInterface;

  SaveAuthstatusUserUsecase({required this.authRepositoryInterface});
  @override
  Future<void> call({String? params}) async {
    return await authRepositoryInterface.saveAuthStatus(authStatus: params!);
  }
}
