import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const SvgIcon('assets/svg/close_ic.svg')),
          const hSpace(30)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          
          children: [
            vSpace(120.w),
            Text(
              'Lets recover your  password',
              style: fontRecoleta(fontSize: 36.sp, color: themeColor),
            ),
            const vSpace(30),
            InputField(
              borderType: InputFieldBorderType.external,
              label: 'Email*',
              hintText: 'Email address',
              textStyle: TextStyle(fontSize: 16.sp),
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              borderColor: const Color(0xff6CD5D8),
            ),
            const vSpace(30),
            PrimaryButton(
              text: 'Continue',
              onPressed: () {
               // Get.toNamed(Routes.forgotNotification);
              },
              isFullWidth: true,
              borderRadius: 12.r,
              backgroundColor: themeColor,
            ),
            const vSpace(30),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Back to sign in',
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
    );
  }
}
