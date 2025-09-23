import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/_controller/login_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.put(Logincontroller());

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
                style: fontDmSans(
                  fontSize: 25.sp,
                  color: kBlack,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'amset app',
                style: fontDmSans(
                  fontSize: 36.sp,
                  color: themeColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => InputField(
                    controller: _controller.emailController,
                    borderType: InputFieldBorderType.external,
                    label: 'Email*',
                    labelStyle: const TextStyle(
                      color: themeColor,
                      letterSpacing: -0.5,
                    ),
                    hintText: 'Email',
                    errorText: _controller.emailError.value.isNotEmpty
                        ? _controller.emailError.value
                        : null,
                    textStyle: TextStyle(fontSize: 16.sp),
                    hintStyle:
                        TextStyle(color: Colors.black.withOpacity(0.5)),
                    borderColor: kTransparent,
                    inputFormatters: [
                      // Lowercase format
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => TextEditingValue(
                          text: newValue.text.toLowerCase(),
                          selection: newValue.selection,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Obx(() => InputField.password(
                    controller: _controller.passwordController,
                    borderType: InputFieldBorderType.external,
                    label: 'Password*',
                    borderColor: kTransparent,
                    hintText: '******',
                    errorText: _controller.passwordError.value.isNotEmpty
                        ? _controller.passwordError.value
                        : null,
                    textStyle: fontDmSans(fontSize: 16.sp, letterSpacing: -0.5),
                    hintStyle: fontDmSans(
                        color: Colors.black.withOpacity(0.5),
                        letterSpacing: -0.5),
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Forgot password navigation
                  },
                  child: const Text(
                    'Forgot my password?',
                    style: TextStyle(
                      letterSpacing: -0.5,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => _controller.isLoading.value
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
                        _controller.login();
                      },
                      isFullWidth: true,
                      borderRadius: 12.r,
                      backgroundColor: kBlack,
                    )),
              const SizedBox(height: 30),
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
              Text(
                'Doesn’t have an account?',
                style: TextStyle(
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.signup);
                },
                child: Text(
                  '  Register here',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
