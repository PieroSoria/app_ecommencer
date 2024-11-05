import 'dart:async';
import 'dart:io';

import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/get_authstatus_user_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/get_token_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/token/save_authstatus_user_usecase.dart';
import 'package:app_ecommencer/features/auth/domain/usecases/user/save_user_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetTokenUsecase getTokenUsecase;
  final SaveUserUsecase saveUserUsecase;
  final GetAuthstatusUserUsecase getAuthstatusUserUsecase;
  final SaveAuthstatusUserUsecase saveAuthstatusUserUsecase;
  AuthBloc(
    this.getTokenUsecase,
    this.saveUserUsecase,
    this.getAuthstatusUserUsecase,
    this.saveAuthstatusUserUsecase,
  ) : super(AuthState.initialState()) {
    on<_OnGetAuthhVerify>(_onGetAuthhVerify);
    on<_OnLoginWithEmail>(_onloginWithEmail);
    on<_OnSaveUserWithEmail>(_onSaveUserWithEmail);
  }

  void _onGetAuthhVerify(
    _OnGetAuthhVerify event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      final authStatus = await getAuthstatusUserUsecase();
      emit(state.copyWith(authStatus: authStatus));
    });
  }

  final name = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final photoUrl = TextEditingController();

  void _onloginWithEmail(
      _OnLoginWithEmail event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.authenticating));
      final data = await getTokenUsecase(params: event.userEntity);
      if (data != null) {
        await saveAuthstatusUserUsecase(params: AuthStatus.authenticated.name);
        emit(state.copyWith(token: data, authStatus: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(authStatus: AuthStatus.authenticatedFailed));
      }
    } catch (e) {
      debugPrint("El error es $e");
      emit(state.copyWith(authStatus: AuthStatus.authenticatedFailed));
    }
  }

  void _onSaveUserWithEmail(
    _OnSaveUserWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final data = await saveUserUsecase(params: event.userEntity);
      if (data) {
        cleanText();
        emit(state.copyWith(authStatus: AuthStatus.authcreateUser));
      }
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.authenticatedFailed));
    }
  }

  void cleanText() {
    name.clear();
    lastname.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
    photoUrl.clear();
  }

  @override
  Future<void> close() {
    name.dispose();
    lastname.dispose();
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
    photoUrl.dispose();
    return super.close();
  }
}
