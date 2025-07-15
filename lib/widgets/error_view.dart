import 'dart:ui';

import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this.apiException, {super.key, this.onRetry});

  final ApiException apiException;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return makeScrollable(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const vSpace(30),
          TextWidget(
            apiException.message,
            height: 1.4,
            fontSize: 15.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
          if (onRetry != null) ...[
            const vSpace(40),
            PrimaryButton(
              text: 'Retry',
              outlined: true,
              height: 40.h,
              isFullWidth: false,
              textStyle: fontDmSans(fontSize: 14.sp),
              onPressed: onRetry!,
            )
          ]
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 40,
            left: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(gradient: gradient()),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.black12,
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x22000000),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 75,
                height: 75,
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: gradientShader(
                  child:
                      Icon(apiException.icon, size: 40, color: Colors.white))),
          Positioned(
            top: -10,
            left: -10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(gradient: gradient()),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  gradient() {
    return const LinearGradient(colors: [Color(0x2207FC00), Color(0x22FFEB3B)]);
  }
}
