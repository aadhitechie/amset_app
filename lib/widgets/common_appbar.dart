import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

AppBar commonAppBar({
  required String greetingText,
  required String nameText,
  required Widget avatar, // changed from String to Widget
  TextStyle? greetingTextStyle,
}) {
  return AppBar(
    backgroundColor: scaffoldBackgroundColor,
    toolbarHeight: 90.h,
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greetingText,
          style: fontDmSans(
            fontSize: 23.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff324F5E),
            letterSpacing: -0.5,
          ),
        ),
        Text(
          nameText,
          style: fontDmSans(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: themeColor,
            letterSpacing: -0.5,
          ),
        ),
      ],
    ),
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          avatar,
        ],
      ),
      const hSpace(10)
    ],
  );
}
