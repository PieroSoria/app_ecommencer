import 'package:app_ecommencer/features/app/presentation/pages/app_page.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/pages/auth_page.dart';
import 'package:app_ecommencer/features/auth/presentation/pages/sign_in_page.dart';
import 'package:app_ecommencer/features/auth/presentation/pages/sign_up_page.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/pages/home_page.dart';
import 'package:app_ecommencer/features/home/presentation/pages/register_producto.dart';
import 'package:app_ecommencer/features/home/presentation/pages/update_producto.dart';
import 'package:app_ecommencer/injector_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const app = '/';
  static const home = '/home';
  static const addproducto = 'add_products';
  static const editproducto = 'edit_products';

  //auth
  static const auth = '/auth';
  static const signin = 'sign_in';
  static const signup = 'sign_up';

  static GoRouter configRoute(AuthStatus status) => GoRouter(
        initialLocation: app,
        routes: [
          GoRoute(
            path: app,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              const AppPage(),
            ),
            redirect: (context, state) => switch (status) {
              AuthStatus.authenticated => home,
              AuthStatus.unauthenticated => auth,
              _ => app,
            },
          ),
          GoRoute(
            path: home,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              MultiBlocProvider(
                providers: [
                  BlocProvider<HomeBloc>(
                    lazy: false,
                    create: (context) => sl(),
                  ),
                  // BlocProvider<CategoryBloc>(
                  //   create: (context) => sl(),
                  // ),
                ],
                child: const HomePage(),
              ),
            ),
            routes: [
              GoRoute(
                path: addproducto,
                name: addproducto,
                pageBuilder: (context, state) => _materialView(
                  state.pageKey,
                  BlocProvider<HomeBloc>(
                    lazy: false,
                    create: (context) => sl(),
                    child: const RegisterProducto(),
                  ),
                ),
              ),
              GoRoute(
                path: editproducto,
                name: editproducto,
                pageBuilder: (context, state) => _materialView(
                  state.pageKey,
                  UpdateProducto(
                    data: state.extra as Map<String, dynamic>,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: auth,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              const AuthPage(),
            ),
            routes: [
              GoRoute(
                path: AppRoutes.signin,
                name: AppRoutes.signin,
                pageBuilder: (context, state) => _materialView(
                  state.pageKey,
                  const SignInPage(),
                ),
              ),
              GoRoute(
                path: AppRoutes.signup,
                name: AppRoutes.signup,
                pageBuilder: (context, state) => _materialView(
                  state.pageKey,
                  const SignUpPage(),
                ),
              ),
            ],
          ),
        ],
      );

  static CustomTransitionPage _materialView(dynamic pagekey, Widget view) {
    return CustomTransitionPage(
      child: view,
      transitionsBuilder: (context, animation, secondary, child) {
        return child;
      },
    );
  }
}
