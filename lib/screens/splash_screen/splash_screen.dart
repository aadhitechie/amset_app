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
    return  Scaffold(
      backgroundColor: Color(0xff043927),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: SvgIcon('assets/svg/logo_new.svg',size: 80.w,)),
        vSpace(5),
        Text('Amset',style:fontRecoleta(color: kWhite,fontSize: 25.sp) ,)
        ],
      ),
    );
  }
}
