import 'dart:developer';
import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/user_model/user_model.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/snackbar_helper.dart';
import 'package:amster_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxString countryIso = 'IN'.obs;
  var validatephoneNo = countries.firstWhere((element) => element.code == 'GB');
  RxString countryCode = '91'.obs;

  // You may want to clear form after registering/logged in
  void clearControllerState() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  JSON getSignUpData() {
    return {
      "fullName": fullNameController.text.trim(),
      "email": emailController.text.toLowerCase(),
      "mobileNumber": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };
  }

  Future registerAndLogin() async {
    final form = signUpFormKey.currentState;
    if (form == null || !form.validate()) return;

    isLoading(true);
    try {
      final signupResponse = await ApiServices(token: false).postMethod(
        ApiEndpoints.register,
        data: getSignUpData(),
      );

      if (signupResponse.data != null &&
          signupResponse.data['success'] == true) {
        // Registration success!
        SnackbarHelper.showSuccess(
            signupResponse.data['message'] ?? 'Registration successful!');

        // Try to auto-login user
        final loginResponse = await ApiServices(token: false).postMethod(
          ApiEndpoints.login,
          data: {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          },
        );

        if (loginResponse.data != null &&
            loginResponse.data['message'] == 'Login successful') {
          final userModel = UserModel.fromJson(loginResponse.data);

          final localStorage = LocalStorage();
          await localStorage.saveToken(userModel.token);
          await localStorage.saveUser(userModel);
          await localStorage.setLogin();

          clearControllerState();
          // SnackbarHelper.showSuccess('Registration & Login successful!');
           Get.offAllNamed(Routes.bottomNav);
          return;
        } else {
          SnackbarHelper.showError(loginResponse.data?['error'] ??
              "Registration succeeded, but auto-login failed.");
        }
      } else {
        SnackbarHelper.showError(signupResponse.data?['error'] ??
            signupResponse.data?['message'] ??
            "Registration failed. Please try again.");
      }
    } catch (e) {
      log('Registration error: $e');
      SnackbarHelper.showError('Unexpected error: $e');
    } finally {
      isLoading(false);
    }
  }
}
