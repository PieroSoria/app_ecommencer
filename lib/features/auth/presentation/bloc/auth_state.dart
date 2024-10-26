part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  authenticating,
  authenticatedFailed,
  logOut,
}

class AuthState extends Equatable {
  final AuthStatus? authStatus;

  const AuthState({this.authStatus});

  factory AuthState.initialState() => const AuthState();

  AuthState copyWith({AuthStatus? authStatus}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [authStatus];
}
