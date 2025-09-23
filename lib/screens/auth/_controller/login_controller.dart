import 'dart:developer';
import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/user_model/user_model.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/snackbar_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logincontroller extends GetxController {
  // Controllers for fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Errors for each field
  final emailError = ''.obs;
  final passwordError = ''.obs;

  // Loading state
  final isLoading = false.obs;

  // Dispose text controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Validate fields before API call
  bool validateFields() {
    emailError.value = '';
    passwordError.value = '';

    bool isValid = true;

    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    }
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    }

    return isValid;
  }

  // Login Function - Handles API and error messaging
  Future<void> login() async {
    if (!validateFields()) return;

    isLoading.value = true;
    try {
      final response = await ApiServices().postMethod(
        ApiEndpoints.login,
        data: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (response.data != null &&
          response.data['message'] == 'Login successful') {
        try {
          final userModel = UserModel.fromJson(response.data);
          final localStorage = LocalStorage();
          await localStorage.saveToken(userModel.token);

          // Fetch Profile
          try {
            final profileResponse = await ApiServices(token: true).getMethod(
              ApiEndpoints.getProfile,
            );

            if (profileResponse.data != null &&
                profileResponse.statusCode == 200) {
              final profileJson = profileResponse.data;
              final freshUserModel = UserModel(
                message: '',
                success: true,
                token: userModel.token,
                user: User.fromJson(profileJson),
              );
              await localStorage.saveUser(freshUserModel);
              await localStorage.setLogin();

              Get.offNamed(Routes.bottomNav);
            } else {
              // fallback: save login response user
              await localStorage.saveUser(userModel);
              await localStorage.setLogin();
              SnackbarHelper.showError(
                  'Partial login: failed to fetch profile, please refresh.');
              Get.offNamed(Routes.bottomNav);
            }
          } catch (e, st) {
            log("Profile fetch failed: $e\n$st");
            await localStorage.saveUser(userModel);
            await localStorage.setLogin();
            SnackbarHelper.showError(
                'Partial login: failed to fetch profile, please refresh.');
            Get.offNamed(Routes.bottomNav);
          }
        } catch (e) {
          log("UserModel parsing failed: $e");
          SnackbarHelper.showError('Failed to parse user data.');
        }
        return;
      }

      // Login failed - show error from API
      final errorMsg = response.data['error'] ?? 'Invalid login credentials.';
      SnackbarHelper.showError(errorMsg);
    } catch (error) {
      log("Login failed: $error");
      String message = 'Something went wrong, please check your credentials.';
      if (error is DioException && error.response?.data != null) {
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data['error'] != null) {
          message = data['error'].toString();
        }
      }
      SnackbarHelper.showError(message);
    } finally {
      isLoading.value = false;
    }
  }
}
