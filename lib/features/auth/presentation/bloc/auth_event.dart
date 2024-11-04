part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  factory AuthEvent.ongetAuthVerify() => _OnGetAuthhVerify();
  factory AuthEvent.onLoginWithEmail({required UserEntity userEntity}) =>
      _OnLoginWithEmail(userEntity: userEntity);
  factory AuthEvent.onSaveUsetWithEmail({required UserEntity userEntity}) =>
      _OnSaveUserWithEmail(userEntity: userEntity);

  @override
  List<Object?> get props => [];
}

class _OnSaveUserWithEmail implements AuthEvent {
  final UserEntity userEntity;

  _OnSaveUserWithEmail({required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnLoginWithEmail implements AuthEvent {
  final UserEntity? userEntity;

  _OnLoginWithEmail({this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetAuthhVerify implements AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
