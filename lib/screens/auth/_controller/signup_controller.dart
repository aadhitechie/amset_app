import 'package:amster_app/routes.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
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
  RxString countryIso = 'GB'.obs;
  var validatephoneNo = countries.firstWhere((element) => element.code == 'GB');
  RxString countryCode = '44'.obs;

  Future<DioResponse> sendSignUpOtp() async {
    return ApiServices(token: false).postMethod(
      ApiEndpoints.register,
      data: getSignUpData(),
    );
  }

  JSON getSignUpData() {
    return {
      "fullName": fullNameController.text.trim(),
      "email": emailController.text.toLowerCase(),
      "mobileNumber": phoneController.text.trim(),
      "password": passwordController.text.trim()
    };
  }

  Future sendOtp() async {
    if (!signUpFormKey.currentState!.validate()) return;
    isLoading(true);
    await sendSignUpOtp().then((value) {
      if (value.statusCode == 200) {
        Get.toNamed(Routes.login);
      }
    }).onError((error, _) {
      Utils.showError(error);
      isLoading(false);
    }).whenComplete(() => isLoading(false));
  }

  static onOtpSuccess(DioResponse response) async {
    //Get.toNamed(Routes.bottomNav);
    // SignUpController.to.clearControllerState();
  }
}