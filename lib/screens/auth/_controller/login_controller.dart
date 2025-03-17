import 'package:amster_app/routes.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/utils.dart';
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
    //   data["phone"] = val; //TODO:check phone ext
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
  login() {
    isLoading(true);

    ApiServices().postMethod(
      ApiEndpoints.login,
      data: {
        'email': emailController.text,
        'password': passwordController.text
      }, // POST data payload
    ).then(
      (value) {
        if (value.data?['message'] == 'Login successful') {
          LocalStorage().saveToken(value.data?['token']);
          LocalStorage().setLogin();
          Get.offNamed(Routes.bottomNav);
          return;
        }
        Utils.showError(const ApiException('Invalid login credentials.'));
      },
    ).onError(
      (error, stackTrace) {
        Utils.showError(const ApiException('Login failed.'));
      },
    ).whenComplete(() => isLoading(false));
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
