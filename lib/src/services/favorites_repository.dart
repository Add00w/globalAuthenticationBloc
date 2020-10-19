import 'package:learning_repo/src/services/auth_repository.dart';

class FavoritesRepository {
  AuthRepo _authRepo;
  FavoritesRepository() {
    _authRepo = AuthRepo();
  }
  Future<String> getMyFavorites() async {
    try {
      if (await _authRepo.isAuthenticated()) {
        return 'since you are authenticated here are your favorites';
      } else
        return null;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
