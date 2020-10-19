import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  Future<void> login() async {
    final String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9'
        '.eyJpc3MiOiJodHRwczpcL1wvc3RhZ2luZy5qb2hyaC5jb20iLCJpYXQiOjE2MDI3NDMxNDUsIm5iZiI6MTYwMjc0MzE0NSwiZXhwIjoxNjAzMzQ3OTQ1LCJkYXRhIjp7InVzZXIiOnsiaWQiOiI4NzE1MCJ9fX0.Ng5tI1hTiqZ3TA_u-MOEcL7PjkNDbHHG-elqV6nnMCM';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 5));
    await _prefs.setString('token', token);
    return null;
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 5));
    if (_prefs.containsKey('token')) return _prefs.getString('token') != null;

    return false;
  }

  Future<void> signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 5));
    if (_prefs.containsKey('token')) await _prefs.remove('token');
  }
}
