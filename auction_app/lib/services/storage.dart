import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }

  Future<bool> hasToken() async {
    String token = await getToken();
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
