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

class SignUpScreen extends GetView<SignupController> {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
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
                    sValidator: CommonValidators.signupEmailValidator,
                    label: 'Email*',
                    hintText: 'Email',
                    textStyle: fontDmSans(
                      fontSize: 14.sp,
                      letterSpacing: -0.5,
                    ),
                    hintStyle: fontDmSans(
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.5,
                    ),
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
                      // Add more password validation rules here if needed
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
                          textStyle: fontDmSans(
                            letterSpacing: -0.5,
                          ),
                          onPressed: () async {
                            final FormState? form = _formKey.currentState;
                            if (form != null && form.validate()) {
                              // Form is valid, proceed with signup
                              if (controller.phoneController.text.isNotEmpty &&
                                  controller.emailController.text.isNotEmpty) {
                                controller.isLoading(true); // Start loading
                                try {
                                  final response = await ApiServices(
                                          token: false)
                                      .postMethod(ApiEndpoints.register, data: {
                                    "fullName":
                                        controller.fullNameController.text,
                                    "email": controller.emailController.text,
                                    "mobileNumber":
                                        controller.phoneController.text,
                                    "password":
                                        controller.passwordController.text,
                                  });

                                  if (response.statusCode == 200) {
                                    // Check for success in the response body
                                    if (response.data != null &&
                                        response.data['success'] == true) {
                                      log('Registration successful! Response: ${response.data}'); // Log the response
                                      try {
                                        Get.offAllNamed(Routes
                                            .login); // Use Get.offAllNamed
                                      } catch (e) {
                                        log('Error navigating to login: $e');
                                      }
                                    } else {
                                      log('Error: Registration failed - ${response.data}'); // Log the entire response data
                                    }
                                  } else {
                                    log('Error: ${response.statusMessage}');
                                  }
                                } catch (e) {
                                  log('Error: $e');
                                } finally {
                                  controller.isLoading(false); // Stop loading
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
                        )),
                  const vSpace(30),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       //Get.toNamed(Routes.signup);
                  //     },
                  //     child: TextWidget(
                  //       'or Register with',
                  //       style: TextStyle(
                  //           fontSize: 14.sp,
                  //           letterSpacing: -0.5,
                  //           color: Colors.black87),
                  //     ),
                  //   ),
                  // ),
                  // const vSpace(20),
                  // Center(
                  //     child: SvgIcon(
                  //   'assets/svg/icons8-google.svg',
                  //   size: 30.w,
                  // ))
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
