import 'package:app_ecommencer/features/app/presentation/bloc/app_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> injectorDependency() async {
  //repository

  
  //usecase

  
  //bloc
  sl.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}
