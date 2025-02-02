// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const TOKEN = 'token';
  static const LOGIN = 'isLogin';
  //-----------------------Basic operations-------------------------------
  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> removeAllItem() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //-----------------------Token-------------------------------
  Future<String?> getToken() async {
    return getString(TOKEN);
  }

  saveToken(String token) async {
    await setString(TOKEN, token);
  }

  clearToken() async {
    await removeItem(TOKEN);
  }

  //-----------------------Login-------------------------------
  Future setLogin() async {
    await setString(LOGIN, 'true');
  }

  Future<bool> isLogin() async {
    var isLogin = await getString(LOGIN);
    return isLogin == 'true';
  }

  Future setSignOut() async {
    await removeAllItem();
  }
}
