import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/_controller/login_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<Logincontroller> {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back to!',
                style: fontDmSans(fontSize: 25.sp, color: kBlack),
              ),
              Text(
                'amset app',
                style: fontDmSans(fontSize: 36.sp, color: themeColor),
              ),
              const vSpace(30),
              InputField(
                controller: controller.emailController,
                borderType: InputFieldBorderType.external,
                label: 'Email*',
                labelStyle: const TextStyle(color: themeColor),
                hintText: 'Email',
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) => TextEditingValue(
                      text: newValue.text.toLowerCase(),
                      selection: newValue.selection,
                    ),
                  ),
                ],
                textStyle: TextStyle(fontSize: 16.sp),
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                borderColor: kTransparent,
              ),
              const vSpace(10),
              InputField.password(
                controller: controller.passwordController,
                borderType: InputFieldBorderType.external,
                label: 'Password*',
                borderColor: kTransparent,
                hintText: '******',
                textStyle: TextStyle(fontSize: 16.sp),
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              const vSpace(10),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.forgotPassword);
                  },
                  child: const Text(
                    'Forgot my password?',
                    style: TextStyle(letterSpacing: 0.1, color: Colors.black54),
                  ),
                ),
              ),
              const vSpace(30),
              Obx(() => controller.isLoading.value
                  ? Center(
                      child: SizedBox(
                          height: 25.h,
                          width: 25.w,
                          child: const CircularProgressIndicator(
                            color: kGreen,
                            backgroundColor: kWhite,
                            strokeCap: StrokeCap.round,
                          )))
                  : PrimaryButton(
                      text: 'Sign in',
                      onPressed: () {
                        controller.login();
                      },
                      isFullWidth: true,
                      borderRadius: 12.r,
                      backgroundColor: kBlack,
                    )),
              const vSpace(30),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    //Get.toNamed(Routes.signup);
                  },
                  child: TextWidget(
                    'or Login with',
                    style: TextStyle(
                        fontSize: 14.sp,
                        letterSpacing: 0.1,
                        color: Colors.black87),
                  ),
                ),
              ),
              const vSpace(20),
              Center(
                  child: SvgIcon(
                'assets/svg/icons8-google.svg',
                size: 30.w,
              ))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: scaffoldBackgroundColor),
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                'Doesn’t have an account?',
                fontSize: 13.sp,
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.signup);
                  },
                  child: TextWidget(
                    '  Register here',
                    fontSize: 13.sp,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
