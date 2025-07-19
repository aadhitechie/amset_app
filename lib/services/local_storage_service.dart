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

  // ---------------------- In-Memory user cache ---------------------- //
  static UserModel? _cachedUser;

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
    _cachedUser = null;
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
    _cachedUser = null;
  }

  // ---------------------- User Model ---------------------- //

  Future<void> saveUser(UserModel user) async {
    await setString(USER, jsonEncode(user.toJson()));
    _cachedUser = user;
  }

  Future<UserModel?> getUser() async {
    final jsonStr = await getString(USER);
    log("Raw user json: $jsonStr");
    if (jsonStr == null) return null;
    _cachedUser = UserModel.fromJson(jsonDecode(jsonStr));
    return _cachedUser;
  }

  Future<void> clearUser() async {
    await removeItem(USER);
    _cachedUser = null;
  }

  // Synchronous user info access (from cache).  
  // Call saveUser(getUserResult) ONCE after login to keep synced!
  UserModel? getUserSync() => _cachedUser;
  String? getUserIdSync() => _cachedUser?.user.id;
  String? getUserEmailSync() => _cachedUser?.user.email;
  String? getUserPhoneSync() => _cachedUser?.user.mobileNumber;

  // On cold start, if cache is null and you need user info, await getUser() first.

  // ---------------------- For Course Purchase UI Logic ---------------------- //

  /// Usage in UI: course.purchasedUsers.contains(LocalStorage().getUserIdSync())
  /// Returns your current user's id (or null if cache not loaded).
  /// No need for purchasedCourses!

  // ---------------------- Job Related ---------------------- //

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
      await saveUser(userModel); // Overwrite updated model and recache
    }
  }

  // ---------------------- Profile update flag ---------------------- //

  Future<void> setProfileUpdated(bool updated) async {
    await setBool(PROFILE_UPDATED, updated);
  }

  Future<bool> isProfileUpdated() async {
    return await getBool(PROFILE_UPDATED) ?? false;
  }
}
