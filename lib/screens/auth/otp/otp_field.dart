import 'package:amster_app/screens/auth/_controller/otp_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';



class OtpField extends GetView<OtpController> {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40.w,
      height: 53.h,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: const Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: kTransparent,
        border: Border.all(color: lightBlue),
        borderRadius: BorderRadius.circular(7.r),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(color: kBlack, fontWeight: FontWeight.w900),
    );
    return Pinput(
        controller: controller.otpFieldController,
        cursor: Padding(
          padding: EdgeInsets.only(top: 35.h),
          child: Container(
            width: 25.w,
            height: 1.h,
            color: themeColor,
          ),
        ),
        length: 6,
        separatorBuilder: (index) {
          return hSpace(index == 2 ? 30 : 10);
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        defaultPinTheme: defaultPinTheme,
        //focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        validator: (s) {
          return null;
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) {
          controller.otp = pin;
        },
        onChanged: controller.checkOtpLength);
  }
}
