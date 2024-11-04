import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/input_custom_auth.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/login_options_widget.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/header_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    context.read<AuthBloc>().cleanText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authenticatedFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  "Error de Authenticacion",
                ),
                dismissDirection: DismissDirection.up,
              ),
            );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: HeaderOption(
                title: "Hello",
                subtitle: "Sign In",
                onTap: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LoginOptions(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: SignInPage._formkey,
                      child: Column(
                        children: [
                          InputCustomAuth(
                            controller: authbloc.email,
                            title: 'Gmail',
                            icons: const Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                          ),
                          InputCustomAuth(
                            controller: authbloc.password,
                            title: 'Password',
                            isPassword: true,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromARGB(255, 157, 10, 0),
                                    Color.fromARGB(255, 11, 0, 46),
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "SIGN IN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't have account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
