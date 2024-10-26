import 'package:app_ecommencer/features/app/presentation/pages/app_page.dart';
import 'package:app_ecommencer/features/auth/presentation/pages/auth_page.dart';
import 'package:app_ecommencer/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const app = '/';
  static const home = '/home';
  static const auth = '/auth';

  static GoRouter configRoute() => GoRouter(
        initialLocation: home,
        routes: [
          GoRoute(
            path: app,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              AppPage(),
            ),
          ),
          GoRoute(
            path: home,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              HomePage(),
            ),
          ),
          GoRoute(
            path: auth,
            pageBuilder: (context, state) => _materialView(
              state.pageKey,
              AuthPage(),
            ),
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
