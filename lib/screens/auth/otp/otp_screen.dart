import 'package:amster_app/screens/auth/_controller/otp_controller.dart';
import 'package:amster_app/screens/auth/otp/otp_field.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const vSpace(11),
                    TextWidget(
                      'Confirmation code',
                      fontSize: 20.sp,
                    ),
                    const vSpace(9),
                    if (controller.isMobileOtp) ...[
                      TextWidget(
                        'OTP send to *${controller.fieldValue["phone"].toString().substring(controller.fieldValue["phone"].length - 3)}',
                        fontSize: 15.sp,
                      ),
                      const vSpace(5)
                    ],
                    TextWidget(
                      'Enter your 6 digit code',
                      fontSize: 10.sp,
                    ),
                    const vSpace(30),
                    const OtpField(),
                    const vSpace(20),
                    Obx(() {
                      bool otpExpired = controller.secondsRemaining.value == 0;
                      return PrimaryButton(
                          width: 310.w,
                          isLoading: controller.isLoading.value,
                          isEnabled:
                              controller.isFullDigit.value && !otpExpired,
                          text: otpExpired ? 'OTP Expired' : 'Confirm',
                          onPressed: otpExpired ? () {} : controller.verifyOtp);
                    })
                  ],
                ),
              ),
              const vSpace(10),
              // ResendOtpButton(controller: controller),
              const vSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
