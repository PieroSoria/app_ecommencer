import 'package:app_ecommencer/core/usecase/use_case.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';

class GetAuthstatusUserUsecase implements UseCase<AuthStatus, void> {
  final AuthRepositoryInterface authRepositoryInterface;

  GetAuthstatusUserUsecase({required this.authRepositoryInterface});
  @override
  Future<AuthStatus> call({void params}) async {
    return await authRepositoryInterface.getverifyAuthStatus();
  }
}
