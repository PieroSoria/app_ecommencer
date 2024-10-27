import 'package:app_ecommencer/features/app/presentation/bloc/app_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/home/data/repositories/products_repository_impl.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';
import 'package:app_ecommencer/features/home/domain/usecases/add_producto_usecase.dart';
import 'package:app_ecommencer/features/home/domain/usecases/get_list_product_usecase.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> injectorDependency() async {
  //repository
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

  //bloc
  sl.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl(),
      sl(),
    ),
  );
}
