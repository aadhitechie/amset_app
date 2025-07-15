import 'dart:developer';

import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/auth/_controller/signup_controller.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
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

class SignUpScreen extends GetWidget<SignupController> {
  const SignUpScreen({super.key});

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
                        style: fontDmSans(fontSize: 25.sp, color: kBlack),
                      ),
                      Text(
                        'amset app',
                        style: fontDmSans(fontSize: 25.sp, color: themeColor),
                      ),
                      Text(
                        ' &',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: kBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    'take the next step in your career!',
                    style: fontDmSans(fontSize: 20.sp, color: kBlack),
                  ),
                  const vSpace(30),
                  InputField(
                    controller: controller.fullNameController,
                    borderType: InputFieldBorderType.external,
                    label: 'Full Name',
                    borderColor: kTransparent,
                    hintText: 'Full Name',
                    textStyle: TextStyle(fontSize: 14.sp),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
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
                    sValidator: CommonValidators.signupEmailValidator,
                    label: 'Email*',
                    hintText: 'Email',
                    textStyle: TextStyle(fontSize: 14.sp),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    borderColor: kTransparent,
                  ),
                  const vSpace(10),
                  reUseCountryTextField(
                      color: kTransparent,
                      fieldName: 'Phone number*',
                      onFieldEntry: (value) {},
                      phoneFieldController: controller.phoneController),
                  const vSpace(10),
                  InputField.password(
                    controller: controller.passwordController,
                    borderType: InputFieldBorderType.external,
                    label: 'Password*',
                    borderColor: kTransparent,
                    hintText: 'Password',
                    textStyle: TextStyle(fontSize: 14.sp),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  const vSpace(10),
                  InputField.password(
                    controller: controller.confirmPasswordController,
                    borderType: InputFieldBorderType.external,
                    label: 'Confirm Password*',
                    borderColor: kTransparent,
                    hintText: 'Confirm Password',
                    textStyle: TextStyle(fontSize: 14.sp),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  const vSpace(30),
                  PrimaryButton(
                    text: 'Sign up',
                    onPressed: () async {
                      if (controller.signUpFormKey.currentState != null &&
                          controller.signUpFormKey.currentState!.validate()) {
                        if (controller.phoneController.text.isNotEmpty &&
                            controller.emailController.text.isNotEmpty) {
                          try {
                            final response = await ApiServices(token: false)
                                .postMethod(ApiEndpoints.register, data: {
                              "fullName": controller.fullNameController.text,
                              "email": controller.emailController.text,
                              "mobileNumber": controller.phoneController.text,
                              "password": controller.passwordController.text,
                            });

                            if (response.statusCode == 200) {
                              Get.toNamed(Routes.login);
                            } else {
                              log('Error: ${response.statusMessage}');
                            }
                          } catch (e) {
                            log('Error: $e');
                          }
                        } else {
                          log("Phone or Email is empty!");
                        }
                      } else {
                        log("Form validation failed!");
                      }
                    },
                    isFullWidth: true,
                    borderRadius: 12.r,
                    backgroundColor: kBlack,
                  ),
                  const vSpace(30),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        //Get.toNamed(Routes.signup);
                      },
                      child: TextWidget(
                        'or Register with',
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
                fontSize: 13.sp,
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.login);
                  },
                  child: TextWidget(
                    '  Login here',
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
