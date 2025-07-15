import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ForgotNotification extends StatelessWidget {
  const ForgotNotification({super.key});

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
            vSpace(20.w),
            Text(
              'We sent you an email',
              style: fontDmSans(fontSize: 36.sp, color: themeColor),
            ),
            const vSpace(30),
            const TextWidget(
                'If you have account with us, you will receive an email with the instruction ho to quickly reset your password.'),
            const vSpace(30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/png/forgot_notification_ic.png'),
              ),
            ),
            const vSpace(30),
            PrimaryButton(
              text: 'Open Mail',
              onPressed: () {},
              isFullWidth: true,
              borderRadius: 12.r,
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
            ),
            const vSpace(20)
          ],
        ),
      ),
    );
  }
}
