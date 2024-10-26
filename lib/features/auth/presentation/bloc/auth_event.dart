part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  factory AuthEvent.ongetAuthVerify() => _OnGetAuthhVerify();

  @override
  List<Object> get props => [];
}

class _OnGetAuthhVerify implements AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
