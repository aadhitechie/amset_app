// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amster_app/screens/auth/user_model/user_model.dart';

class LocalStorage {
  // ---------------------- Keys ---------------------- //
  static const TOKEN = 'token';
  static const LOGIN = 'isLogin';
  static const USER = 'user_data';
  static const APPLIED_JOBS = 'applied_jobs';
  static const SAVED_JOBS = 'saved_jobs';
  static const PROFILE_UPDATED = 'profile_updated';


  // ---------------------- Basic Operations ---------------------- //

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

  // ---------------------- Token ---------------------- //

  Future<String?> getToken() async {
    return getString(TOKEN);
  }

  Future<void> saveToken(String token) async {
    await setString(TOKEN, token);
  }

  Future<void> clearToken() async {
    await removeItem(TOKEN);
  }

  // ---------------------- Login ---------------------- //

  Future<void> setLogin() async {
    await setString(LOGIN, 'true');
  }

  Future<bool> isLogin() async {
    final isLogin = await getString(LOGIN);
    return isLogin == 'true';
  }

  Future<void> setSignOut() async {
    await removeAllItem();
  }

  // ---------------------- User Model ---------------------- //

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

  // ---------------------- Applied Jobs ---------------------- //

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

  // ---------------------- Saved Jobs ---------------------- //

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

  /// Add job ID to `savedJobs` inside the stored `UserModel`
  Future<void> addSavedJobToUser(String jobId) async {
    final userModel = await getUser();
    if (userModel != null && !userModel.user.savedJobs.contains(jobId)) {
      userModel.user.savedJobs.add(jobId);
      await saveUser(userModel); // Overwrite updated model
    }
  }


  Future<void> setProfileUpdated(bool updated) async {
  await setBool(PROFILE_UPDATED, updated);
}

Future<bool> isProfileUpdated() async {
  return await getBool(PROFILE_UPDATED) ?? false;
}
}
