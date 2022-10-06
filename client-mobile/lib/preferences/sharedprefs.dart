import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String tokenkey = "Tkey";
  static String headerKey = "Hkey";
  static String sharePreferenceLoggedInKey = 'ISLOGIN';

  static Future<bool> saveUserLoggedInSharedPreference(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharePreferenceLoggedInKey, isLoggedIn);
  }

  static Future<bool> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(tokenkey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenkey);
  }

  static Future<bool> setHeader(String header) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(headerKey, header);
  }

  static Future<String?> getHeader() async {
    final prefs = await SharedPreferences.getInstance();
    String? header = prefs.getString(headerKey);
    return header;
  }
}

class ConstantDetails {
  static String? tokenString = '';
  static String? headerString = '';
}
