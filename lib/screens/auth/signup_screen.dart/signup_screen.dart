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


class SignUpScreen extends GetWidget<SignupController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: controller.signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const vSpace(60),
                Text(
                  'Customer Sign up',
                  style: fontRecoleta(fontSize: 36.sp, color: themeColor),
                ),
                const vSpace(30),
                InputField(
                  controller: controller.fullNameController,
                  borderType: InputFieldBorderType.external,
                  label: 'Full Name',
                  borderColor: const Color(0xff6CD5D8),
                  hintText: 'Full Name',
                  textStyle: TextStyle(fontSize: 16.sp),
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
                  hintText: 'Email address',
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: const Color(0xff6CD5D8),
                ),
                const vSpace(20),
            
                reUseCountryTextField(
                    fieldName: 'Phone number',
                    onFieldEntry: (value) {},
                    phoneFieldController: controller.phoneController),
            
                // InputField(
                //   borderType: InputFieldBorderType.external,
                //   label: 'Email*',
                //   hintText: 'Email address',
                //   textStyle: TextStyle(fontSize: 16.sp),
                //   hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                //   borderColor: const Color(0xff6CD5D8),
                // ),
                // const vSpace(10),
                // InputField(
                //   borderType: InputFieldBorderType.external,
                //   label: 'Phone',
                //   hintText: 'Phone Number',
                //   textStyle: TextStyle(fontSize: 16.sp),
                //   hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                //   borderColor: const Color(0xff6CD5D8),
                // ),
                const vSpace(10),
                InputField.password(
                  controller: controller.passwordController,
                  borderType: InputFieldBorderType.external,
                  label: 'Password*',
                  borderColor: const Color(0xff6CD5D8),
                  hintText: '',
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                const vSpace(10),
                InputField.password(
                  controller: controller.confirmPasswordController,
                  borderType: InputFieldBorderType.external,
                  label: 'Confirm Password*',
                  borderColor: const Color(0xff6CD5D8),
                  hintText: '',
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
                const vSpace(30),
                PrimaryButton(
                  text: 'Sign up',
                  onPressed: () {
                    //  Get.toNamed(Routes.otp);
                    //  if ( controller.signUpFormKey.currentState!.validate()) {
            
                    //  }
                   // controller.sendOtp();
            
                    // if (controller.phoneController.text.isNotEmpty &&
                    //     controller.emailController.text.isNotEmpty) {
            
                    //   print(controller.countryCode);
                    //   print(controller.countryCode);
                    // }
                    // controller.signUpFormKey.currentState!.validate();
                  },
                  isFullWidth: true,
                  borderRadius: 12.r,
                  backgroundColor: themeColor,
                ),
                const vSpace(30),
                GestureDetector(
                  onTap: () {
                   // Get.toNamed(Routes.login);
                  },
                  child: TextWidget(
                    'back to sign in',
                    style: TextStyle(
                        fontSize: 16.sp,
                        decorationColor: const Color(0xff227E95),
                        color: const Color(0xff227E95)),
                  ),
                ),
                const vSpace(10),
                GestureDetector(
                  onTap: () {
                    //Get.toNamed(Routes.forgotPassword);
                  },
                  child: const Text(
                    'Forgot  my password?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff227E95),
                        color: Color(0xff227E95)),
                  ),
                ),
                const vSpace(30),
                RichText(
                  text: TextSpan(
                    text:
                        'This app is currently available only to customers on a medication programme. You can see if you are eligible on',
                    style: TextStyle(fontSize: 16.sp, color: kBlack),
                    children: [
                      TextSpan(
                        text: ' Dr.frank.co.uk',
                        style: TextStyle(fontSize: 16.sp, color: themeColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
