import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_repo/src/services/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    _authRepo = AuthRepo();
  }
  AuthRepo _authRepo;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    debugPrint(state.toString());
    if (event is IsAuthenticated) {
      bool isAuthenticated = await _authRepo.isAuthenticated();
      yield AuthLoading();
      if (isAuthenticated) {
        yield AuthenticatedState();
      } else {
        yield UnAuthenticatedState();
      }
    } else if (event is Authenticate) {
      yield AuthLoading();
      await _authRepo.login();
      yield AuthenticatedState();
    } else if (event is SignOut) {
      yield AuthLoading();
      await _authRepo.signOut();
      yield UnAuthenticatedState();
    }
  }
}
