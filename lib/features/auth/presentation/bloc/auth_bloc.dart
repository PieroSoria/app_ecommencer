import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initialState()) {
    on<_OnGetAuthhVerify>(_onGetAuthhVerify);
  }

  void _onGetAuthhVerify(_OnGetAuthhVerify event, Emitter<AuthState> emit) {
    emit(state.copyWith(authStatus: AuthStatus.authenticated));
  }
}
