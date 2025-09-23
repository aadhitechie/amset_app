import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/_controller/signup_controller.dart';
import 'package:amster_app/utils/common_svalidators.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/phone_field.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignupController> {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const vSpace(50),
                  Row(
                    children: [
                      Text(
                        'join ',
                        style: fontDmSans(
                          fontSize: 25.sp,
                          color: kBlack,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'amset app',
                        style: fontDmSans(
                          fontSize: 25.sp,
                          color: themeColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        ' &',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'take the next step in your career!',
                    style: fontDmSans(
                      fontSize: 20.sp,
                      color: kBlack,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const vSpace(30),
                  InputField(
                    controller: controller.fullNameController,
                    borderType: InputFieldBorderType.external,
                    label: 'Full Name',
                    borderColor: kTransparent,
                    hintText: 'Full Name',
                    textStyle: fontDmSans(fontSize: 14.sp, letterSpacing: -0.5),
                    hintStyle: fontDmSans(
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const vSpace(10),
                  InputField(
                    controller: controller.emailController,
                    borderType: InputFieldBorderType.external,
                    inputFormatters: [
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => TextEditingValue(
                          text: newValue.text.toLowerCase(),
                          selection: newValue.selection,
                        ),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    sValidator: CommonValidators.signupEmailValidator,
                    label: 'Email*',
                    hintText: 'Email',
                    textStyle: fontDmSans(fontSize: 14.sp, letterSpacing: -0.5),
                    hintStyle: fontDmSans(
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.5,
                    ),
                    borderColor: kTransparent,
                  ),
                  const vSpace(10),
                  Obx(() => reUseCountryTextField(
                        color: kTransparent,
                        fieldName: 'Phone number*',
                        phoneFieldController: controller.phoneController,
                        focusNode: controller.phoneFocusNode,
                        onFieldEntry: (value) => controller.validatePhoneField(),
                        errorText: controller.phoneError.value.isNotEmpty
                            ? controller.phoneError.value
                            : null,
                      )),
                  const vSpace(10),
                  InputField.password(
                    controller: controller.passwordController,
                    borderType: InputFieldBorderType.external,
                    label: 'Password*',
                    borderColor: kTransparent,
                    hintText: 'Password',
                    textStyle: fontDmSans(
                      fontSize: 14.sp,
                      letterSpacing: -0.5,
                    ),
                    hintStyle: fontDmSans(
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const vSpace(10),
                  InputField.password(
                    controller: controller.confirmPasswordController,
                    borderType: InputFieldBorderType.external,
                    label: 'Confirm Password*',
                    borderColor: kTransparent,
                    hintText: 'Confirm Password',
                    textStyle: fontDmSans(
                      fontSize: 14.sp,
                      letterSpacing: -0.5,
                    ),
                    hintStyle: fontDmSans(
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
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
                          text: 'Sign up',
                          textStyle: fontDmSans(letterSpacing: -0.5),
                          onPressed: () => controller.registerAndLogin(),
                          isFullWidth: true,
                          borderRadius: 12.r,
                          backgroundColor: kBlack,
                        )),
                  const vSpace(30),
                ],
              ),
            ),
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
                'Already have an account?',
                letterSpacing: -0.5,
                fontSize: 14.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.login);
                },
                child: TextWidget(
                  '  Login here',
                  fontSize: 14.sp,
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
