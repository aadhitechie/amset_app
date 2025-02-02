import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';


AppBar commonAppBar({
  required String greetingText,
  required String nameText,
  required String locationInfo,
}) {
  return AppBar(
    backgroundColor: scaffoldBackgroundColor,
    toolbarHeight: 90.h,
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          greetingText,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xff324F5E),
        ),
        TextWidget(
          nameText,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xff227E95),
        ),
        TextWidget(
          locationInfo,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xff96A7AF),
        ),
      ],
    ),
    actions: [
      SvgIcon(
        'assets/svg/appbar_ic.svg',
        size: 64.h,
      ),
      const hSpace(10)
    ],
  );
}
