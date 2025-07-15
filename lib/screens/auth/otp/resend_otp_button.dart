

import 'package:amster_app/screens/auth/_controller/otp_controller.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class ResendOtpButton extends StatefulWidget {
  const ResendOtpButton({
    super.key,
    required this.controller,
  });

  final OtpController controller;

  @override
  State<ResendOtpButton> createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.startTimer());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: widget.controller.secondsRemaining.value == 0,
        replacement:
            Text('Resend code in ${widget.controller.secondsRemaining.value}'),
        child: PrimaryButton(
          outlined: true,
          text: 'Resend OTP',
          textStyle: fontDmSans(fontWeight: FontWeight.w500),
          isLoading: widget.controller.isResending.value,
          onPressed: widget.controller.resendOtp,
          width: 310.w,
        ),
      ),
    );
  }
}
