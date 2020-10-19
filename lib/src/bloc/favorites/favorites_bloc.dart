import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_repo/src/bloc/auth/auth_bloc.dart';
import 'package:learning_repo/src/services/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._authBloc) : super(FavoritesInitial()) {
    _favoritesRepository = FavoritesRepository();
    // _authBloc = AuthBloc();
    _subscription = _authBloc.listen((authstate) {
      print('from fav bloc:$authstate');
      if (authstate is UnAuthenticatedState || authstate is AuthenticatedState)
        add(GetFavorites());
    });
  }
  AuthBloc _authBloc;
  StreamSubscription _subscription;

  @override
  Future<Function> close() {
    _subscription?.cancel();
    super.close();
  }

  FavoritesRepository _favoritesRepository;
  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavorites) {
      var response = await _favoritesRepository.getMyFavorites();
      if (response != null) {
        yield FavoritesLoaded(data: response);
      } else
        yield AuthenticateToGetYourFavorites();
    }
  }
}
