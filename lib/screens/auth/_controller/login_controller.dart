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
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  JSON getApiFieldVal(String val) {
    JSON data = {
      'email': '',
      'phone': '',
    };
    return data;
  }

  login() async {
    isLoading(true);
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
          // Initial parse: get userModel from login response
          final userModel = UserModel.fromJson(response.data);

          final localStorage = LocalStorage();
          await localStorage.saveToken(userModel.token);

          // ------- Fetch Latest Profile ----------
          try {
            final profileResponse = await ApiServices(token: true).getMethod(
              ApiEndpoints.getProfile,
            );

            log("Profile fetch status: ${profileResponse.statusCode}");
            log("Profile fetch body: ${profileResponse.data}");

            if (profileResponse.data != null &&
                profileResponse.statusCode == 200) {
              // Profile API returns the plain user model (map)
              final profileJson = profileResponse.data;

              final freshUserModel = UserModel(
                message: '', // Or profileJson['message'] if server provides
                success: true,
                token: userModel.token,
                user: User.fromJson(profileJson),
              );
              await localStorage.saveUser(freshUserModel);
              await localStorage.setLogin();

              log("✅ Saved user full name (profile): ${freshUserModel.user.fullName}");

              // SnackbarHelper.showSuccess('Logged in successfully!');
              Get.offNamed(Routes.bottomNav);
            } else {
              // fallback: still save login response user
              await localStorage.saveUser(userModel);
              await localStorage.setLogin();

              SnackbarHelper.showError(
                  'Partial login: failed to fetch profile, please refresh.');
              Get.offNamed(Routes.bottomNav);
            }
          } catch (e, st) {
            log("Profile fetch after login failed: $e\n$st");
            // fallback: still save login response user
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

      // if we reach here, login failed but no exception
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
      isLoading(false);
    }
  }

  static onOtpSuccess(DioResponse response) {
    LocalStorage().setLogin();
    //Get.offAllNamed(Routes.bottomNav);
  }

  Future<DioResponse> sendLoginOtp() async {
    return ApiServices(token: false).postMethod(ApiEndpoints.login, data: {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    });
  }
}
