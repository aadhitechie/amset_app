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
    // if (isNumeric(val)) {
    //   data["phone"] = val;
    // } else if (val.isEmail) {
    //   data["email"] = val;
    // } else if (isUsername(val)) {
    //   data["username"] = val;
    // }
    return data;
  }

  // Future login() async {
  //   //if (!formKey.currentState!.validate()) return;
  //   isLoading(true);
  //   // usernameText = loginFieldController.text;
  //   sendLoginOtp().then((response) {
  //     if (response.data['status'] == "success") {
  //      print('loginn');
  //     }
  //   }).onError((error, _) {
  //     Utils.showError(error);
  //   }).whenComplete(() => isLoading(false));
  // }

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
          final userModel = UserModel.fromJson(response.data);

          final localStorage = LocalStorage();
          await localStorage.saveToken(userModel.token);
          await localStorage.saveUser(userModel);
          await localStorage.setLogin();

          log("✅ Saved user full name: ${userModel.user.fullName}");

          // SnackbarHelper.showSuccess('Logged in successfully!');
          Get.offNamed(Routes.bottomNav);
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

      // try to extract server error message
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
