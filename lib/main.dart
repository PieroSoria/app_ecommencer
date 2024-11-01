import 'package:app_ecommencer/core/routes/app_routes.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_ecommencer/injector_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectorDependency();
  runApp(const BlocPorviders());
}

class BlocPorviders extends StatelessWidget {
  const BlocPorviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl()..add(AuthEvent.ongetAuthVerify()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => sl(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'App Ecommencer',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: AppRoutes.configRoute(
              state.authStatus ?? AuthStatus.unauthenticated,
            ),
          );
        },
      );
    });
  }
}
