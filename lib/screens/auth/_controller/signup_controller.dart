import 'dart:developer';

import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/user_model/user_model.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();

  // Form controllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Form key
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Loading state
  RxBool isLoading = false.obs;

  // Phone field
  FocusNode phoneFocusNode = FocusNode();
  RxString phoneError = ''.obs;

  RxString countryIso = 'IN'.obs;
  var validatephoneNo = countries.firstWhere((element) => element.code == 'GB');
  RxString countryCode = '91'.obs;

  @override
  void onInit() {
    super.onInit();
    phoneFocusNode.addListener(() {
      if (!phoneFocusNode.hasFocus) {
        validatePhoneField();
      }
    });
  }

  // Clear all fields
  void clearControllerState() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneError.value = '';
  }

  // Validate phone field on unfocus
  void validatePhoneField() {
    final value = phoneController.text.trim();
    if (value.isEmpty) {
      phoneError.value = 'Please enter your phone number';
    } else if (value.length < 10) {
      // adjust validation logic based on your requirement
      phoneError.value = 'Invalid phone number';
    } else {
      phoneError.value = '';
    }
  }

  Map<String, dynamic> getSignUpData() {
    return {
      "fullName": fullNameController.text.trim(),
      "email": emailController.text.toLowerCase(),
      "mobileNumber": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };
  }

  Future registerAndLogin() async {
    final form = signUpFormKey.currentState;
    validatePhoneField(); // validate phone on submit, too

    // Stop submission if form invalid or phone error present
    if (form == null || !form.validate() || phoneError.value.isNotEmpty) return;

    isLoading(true);
    try {
      final signupResponse = await ApiServices(token: false).postMethod(
        ApiEndpoints.register,
        data: getSignUpData(),
      );

      if (signupResponse.data != null &&
          signupResponse.data['success'] == true) {
        SnackbarHelper.showSuccess(
            signupResponse.data['message'] ?? 'Registration successful!');

        // Auto-login attempt
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
