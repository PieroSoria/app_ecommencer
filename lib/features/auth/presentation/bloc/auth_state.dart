part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  authenticating,
  authenticatedFailed,
  authcreateUser,
  logOut,
}

class AuthState extends Equatable {
  final AuthStatus? authStatus;
  final String? token;
  final File? imagen;
  const AuthState({
    this.authStatus,
    this.token,
    this.imagen,
  });

  factory AuthState.initialState() => const AuthState();

  AuthState copyWith({AuthStatus? authStatus, String? token, File? imagen}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      token: token ?? this.token,
      imagen: imagen ?? this.imagen,
    );
  }

  @override
  List<Object?> get props => [authStatus, token, imagen];
}
