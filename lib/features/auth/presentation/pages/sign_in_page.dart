import 'dart:ui';

import 'package:app_ecommencer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_ecommencer/features/auth/presentation/widgets/input_custom_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authbloc = context.read<AuthBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _headerOptions(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginOptions(context, authbloc),
          ),
        ],
      ),
    );
  }

  Container _loginOptions(BuildContext context, AuthBloc authbloc) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.4,
      padding: const EdgeInsets.only(
        top: 70,
        left: 30,
        right: 30,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _optionformkey(authbloc, context),
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
    );
  }

  Form _optionformkey(AuthBloc authbloc, BuildContext context) {
    return Form(
      key: _formkey,
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
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
    );
  }

  Container _headerOptions(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.8,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 157, 10, 0),
            Color.fromARGB(255, 11, 0, 46),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Sign In",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
