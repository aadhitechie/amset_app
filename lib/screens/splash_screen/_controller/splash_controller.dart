import 'dart:async';

import 'package:amster_app/routes.dart';
import 'package:amster_app/utils/api_error_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with ApiErrorMixin {
  @override
  void onInit() {
    super.onInit();
    print('onSplash init');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
       Get.toNamed(Routes.onBoarding);
      });
    });

    //checkStuck();
  }

  // navigate() async {
  //   bool isInitUriHandled = await DeepLinkListener.initialize();
  //   if (isInitUriHandled) return;
  //   checkLoginStatus();
  // }

  // checkStuck() {
  //   Timer(const Duration(seconds: 6), () {
  //     if (Get.routing.current == Routes.splash) {
  //       log('stuck on Splash');
  //       checkLoginStatus();
  //     }
  //   });
  // }

  // checkLoginStatus() async {
  //   if (GlobalService.to.isUIMode) {
  //     GlobalService.to.userProfile = TempDB.tempProfile;
  //     Get.offAllNamed(Routes.mainPageRoute);
  //     return;
  //   }

  //   bool isLogin = await LocalStorage().isLogin();
  //   if (isLogin) {
  //     profileLoaded = await loadProfileData();
  //     if (isErrorState.value) return;
  //     await biometricAuth();
  //     if (biometricAuthStatus == BiometricAuthStatus.unauthenticated) return;
  //     if (profileLoaded) {
  //       Get.offAllNamed(Routes.mainScreen);
  //       return;
  //     }
  //   }
  //   Get.offAllNamed(Routes.logoScreen);
  // }
}
