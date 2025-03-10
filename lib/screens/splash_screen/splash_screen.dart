import 'package:amster_app/screens/splash_screen/_controller/splash_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff043927),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
             
              children: [
                Center(
                  child: SvgIcon(
                    'assets/svg/logo_new.svg',
                    size: 190.w,
                  ),
                ),
                TextWidget(
                  ' amset',
                  style: fontRecoleta(
                      color: kWhite,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '#futureset!',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 15.sp,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: TextWidget(
              'www.amsetacademy.com',
              color: kWhite,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      // bottomSheet: Padding(
      //   padding: EdgeInsets.only(bottom: 20.w),
      //   child: TextWidget(
      //     'www.amsetacademy.com',
      //     color: kWhite,
      //     fontSize: 20.sp,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
    );
  }
}
