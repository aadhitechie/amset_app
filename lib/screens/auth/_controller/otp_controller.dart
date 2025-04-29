import 'dart:async';


import 'package:amster_app/routes.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class OtpController extends GetxController {
  static OtpController get to => Get.find();
  RxBool isLoading = false.obs;
  final TextEditingController otpFieldController = TextEditingController();

  String otp = '';
  // bool isLogin = false;
  RxBool isFullDigit = false.obs;
  RxBool invalidOtp = false.obs;

  late Future Function() _resendOtp;
  late Function(DioResponse response) onSuccess;
  late VoidCallback onBackPress;
  RxInt secondsRemaining = 60.obs;
  bool isMobileOtp = false;
  late Timer timer;
  late JSON fieldValue;
  RxBool isResending = false.obs;

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    onBackPress = Get.arguments['onBackPress'];
    _resendOtp = Get.arguments['resendOtp'];
    fieldValue = Get.arguments['fieldValue'];
    onSuccess = Get.arguments['onSuccess'];
    isMobileOtp = Get.arguments['isMobileOtp'] ?? false;
  }

  checkOtpLength(String value) {
    if (value.length == 6) {
      isFullDigit(true);
    } else {
      isFullDigit(false);
    }
  }

  Future verifyOtp() async {
    isLoading(true);
    ApiServices(token: false).postMethod(ApiEndpoints.verifyOtp, data: {
     ...fieldValue,
      "otp": otp,
      "need_token": true,
      // "device_info": {
      //   "device_id": deviceID,
      //   "device_model": deviceModel,
      //   "fcm_token": fcmToken,
      //   "platform": Platform.isAndroid ? "ANDROID" : "IOS",
      //   "ip_address": ipAddress
      // },
    }).then((response) {
      if (response.data['status'] == "success") {
        String token = response.data['access_token']['value'];
        LocalStorage().saveToken(token);
        ApiServices.token = token;

        onSuccess.call(response);
      } else if (response.data['status'] == "failed") {
        invalidOtp(true);
        Utils.showError(ApiException(response.data['message']));
      }
    }).onError((error, _) {
      if (kDebugMode) {
        print(_.toString());
      }
      Utils.showError(error);
    }).whenComplete(() => isLoading(false));
  }

  void startTimer() {
    secondsRemaining.value = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (secondsRemaining.value == 0) {
          timer.cancel();
        } else {
          secondsRemaining.value--;
        }
      },
    );
  }

  resendOtp() {
    invalidOtp(false);
    isResending(true);
    otpFieldController.clear();
    isFullDigit(false);
    _resendOtp().then((value) {
      Utils.showSuccess('OTP Sent Successfully');
      startTimer();
    }).onError((error, _) {
      Utils.showError(const ApiException('OTP Send Failed'));
    }).whenComplete(() {
      isResending(false);
    });
  }

  static void gotoOTp(
      {required VoidCallback onBackPress,
      required Future<DioResponse> Function() onResendOtp,
      required JSON confirmFieldValue,
      required Function(DioResponse response) onSuccess,
      bool isMobileOtp = false}) {
    Get.offAllNamed(
      Routes.otp,
       arguments: {
      "resendOtp": onResendOtp,
      "fieldValue": confirmFieldValue,
      "onBackPress": onBackPress,
      "onSuccess": onSuccess,
      "isMobileOtp": isMobileOtp
    });
  }




}
