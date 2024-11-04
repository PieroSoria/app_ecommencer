import 'package:app_ecommencer/features/app/presentation/bloc/app_bloc.dart';
import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_impl.dart';
import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_interface.dart';
import 'package:app_ecommencer/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/get_token_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/user/save_user_usecase.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/home/data/repositories/products_repository_impl.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';
import 'package:app_ecommencer/features/home/domain/usecases/add_producto_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/delete_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/get_list_product_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/update_producto_usecase.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> injectorDependency() async {
  //services
  sl.registerLazySingleton<AuthLocalRepositoryInterface>(
    () => AuthLocalRepositoryImpl(),
  );

  //repository
  sl.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepositoryImpl(
      authLocalRepositoryInterface: sl(),
    ),
  );
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(),
  );

  //usecase
  sl.registerLazySingleton<GetListProductUsecase>(
    () => GetListProductUsecase(
      productsRepository: sl(),
    ),
  );
  sl.registerLazySingleton<AddProductoUsecase>(
    () => AddProductoUsecase(
      productsRepository: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateProductoUsecase>(
    () => UpdateProductoUsecase(
      productsRepository: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteProductUsecase>(
    () => DeleteProductUsecase(
      productsRepository: sl(),
    ),
  );
  sl.registerLazySingleton<GetTokenUsecase>(
    () => GetTokenUsecase(
      authRepositoryInterface: sl(),
    ),
  );
  sl.registerLazySingleton<SaveUserUsecase>(
    () => SaveUserUsecase(
      authRepositoryInterface: sl(),
    ),
  );

  //bloc
  sl.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl(),
      sl(),
    ),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}
