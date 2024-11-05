import 'package:app_ecommencer/core/helper/database_repository.dart';
import 'package:app_ecommencer/core/helper/database_repository_impl.dart';
import 'package:app_ecommencer/features/app/presentation/bloc/app_bloc.dart';
import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_impl.dart';
import 'package:app_ecommencer/features/auth/data/datasources/auth_local_repository_interface.dart';
import 'package:app_ecommencer/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_ecommencer/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/get_authstatus_user_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/get_token_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/save_authstatus_user_usecase.dart';
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
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> injectorDependency() async {
  //services
  final mydb = await initialDataBaseServices();
  sl.registerLazySingleton<DatabaseRepository>(
    () => DatabaseRepositoryImpl(mydb: mydb),
  );
  sl.registerLazySingleton<AuthLocalRepositoryInterface>(
    () => AuthLocalRepositoryImpl(mydb: mydb),
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
  //auth usecase
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
  sl.registerLazySingleton<GetAuthstatusUserUsecase>(
    () => GetAuthstatusUserUsecase(
      authRepositoryInterface: sl(),
    ),
  );
  sl.registerLazySingleton<SaveAuthstatusUserUsecase>(
    () => SaveAuthstatusUserUsecase(
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

Future<Database> initialDataBaseServices() async {
  final path = await getDatabasesPath();
  final pathio = join(path, 'app_ecommemr.db');
  final mydb = await openDatabase(
    pathio,
    onCreate: (db, version) {
      db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    lastname TEXT,
    email TEXT,
    password TEXT,
    photo_url TEXT,
    fcm_token TEXT
  )
''');
      db.execute('''
  CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    precio TEXT,
    imagen BLOB,
    created_at TEXT
  )
''');
    },
    version: 1,
  );
  return mydb;
}
