import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/header_options_widget.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/input_custom_auth.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/login_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        if (state.authStatus == AuthStatus.authcreateUser) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  "Felicitaciones se creo el usuario",
                ),
                dismissDirection: DismissDirection.up,
              ),
            );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: HeaderOption(
                title: "Create Your",
                subtitle: "Account",
                onTap: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LoginOptions(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: SignUpPage._formkey,
                        child: Column(
                          children: [
                            InputCustomAuth(
                              controller: authbloc.name,
                              title: 'Nombres',
                              icons: const Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                            ),
                            InputCustomAuth(
                              controller: authbloc.lastname,
                              title: 'Apellidos',
                              icons: const Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                            ),
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
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "no puede estar vacio el password";
                                }
                                return null;
                              },
                            ),
                            InputCustomAuth(
                              controller: authbloc.confirmpassword,
                              title: 'Confirmar Password',
                              isPassword: true,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "no puede estar vacio el password";
                                }
                                if (value != authbloc.password.text) {
                                  return "La claves no coinciden";
                                }
                                return null;
                              },
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: const Padding(
                            //       padding: EdgeInsets.only(top: 20),
                            //       child: Text(
                            //         "Forgot password?",
                            //         style: TextStyle(
                            //             color: Colors.black, fontSize: 18),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                if (SignUpPage._formkey.currentState!
                                    .validate()) {
                                  authbloc.add(
                                    AuthEvent.onSaveUsetWithEmail(
                                      userEntity: UserEntity(
                                        id: 0,
                                        name: authbloc.name.text,
                                        lastname: authbloc.lastname.text,
                                        email: authbloc.email.text,
                                        password: authbloc.password.text,
                                        photoUrl: authbloc.photoUrl.text,
                                        fcmToken: "",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                  "SIGN UP",
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
                                "Sign in",
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
            ),
          ],
        ),
      ),
    );
  }
}
