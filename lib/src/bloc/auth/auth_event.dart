part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class IsAuthenticated extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Authenticate extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
