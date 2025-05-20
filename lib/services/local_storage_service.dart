// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:amster_app/screens/auth/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const TOKEN = 'token';
  static const LOGIN = 'isLogin';
  static const USER = 'user_data';
  static const APPLIED_JOBS = 'applied_jobs';
  static const SAVED_JOBS = 'saved_jobs';
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

  //-----------------------User-------------------------------
  Future<void> saveUser(UserModel user) async {
    await setString(USER, jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final jsonStr = await getString(USER);
    log("Raw user json: $jsonStr");
    if (jsonStr == null) return null;
    return UserModel.fromJson(jsonDecode(jsonStr));
  }

  Future<void> clearUser() async {
    await removeItem(USER);
  }

//-----------------------storing applied job IDs-------------------------------

  Future<void> addAppliedJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(APPLIED_JOBS) ?? [];
    if (!existing.contains(jobId)) {
      existing.add(jobId);
      await prefs.setStringList(APPLIED_JOBS, existing);
    }
  }

  Future<bool> isJobApplied(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final appliedJobs = prefs.getStringList(APPLIED_JOBS) ?? [];
    return appliedJobs.contains(jobId);
  }

//-----------------------storing saved job IDs-------------------------------

  Future<void> addSavedJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(SAVED_JOBS) ?? [];
    if (!existing.contains(jobId)) {
      existing.add(jobId);
      await prefs.setStringList(SAVED_JOBS, existing);
    }
  }

  Future<bool> isJobSaved(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJobs = prefs.getStringList(SAVED_JOBS) ?? [];
    return savedJobs.contains(jobId);
  }
}
