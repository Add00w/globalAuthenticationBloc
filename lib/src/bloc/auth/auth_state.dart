part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
