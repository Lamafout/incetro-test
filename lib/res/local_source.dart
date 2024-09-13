import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalSource{
  final SharedPreferences sharedPreferences;
  LocalSource(this.sharedPreferences);

  Future<String?> getToken(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<void> setToken(String key, String value) async {
    sharedPreferences.setString(key, value);
  }
}