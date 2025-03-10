import 'dart:io';

import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '_controller/bottomnav_controller.dart';

class BottomNavScreen extends GetWidget<BottomNavController> {
  const BottomNavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.children[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x22839566).withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: const Offset(0.0, 0.0)),
              ]),
          clipBehavior: Clip.hardEdge,
          child: CupertinoTabBar(
              height: Platform.isIOS ? 70.h : 80.h,
              onTap: controller.onTabTapped,
              currentIndex: controller.currentIndex.value,
              items: [
                bottomNavItem(0, "Home",
                    icon: 'assets/svg/amset-home-outlined.svg',
                    activeIcon: 'assets/svg/amset-home-fill.svg'),
                bottomNavItem(1, "Job",
                    icon: 'assets/svg/job-outlined.svg',
                    activeIcon: 'assets/svg/job-fill.svg'),
                bottomNavItem(2, "Course",
                    icon: 'assets/svg/course-outined.svg',
                    activeIcon: 'assets/svg/course-fill.svg'),
                bottomNavItem(3, "Profile",
                    icon: 'assets/svg/profile-outlined.svg',
                    activeIcon: 'assets/svg/profile-fill.svg'),
              ]),
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavItem(int index, String label,
      {Widget? customIcon, String? icon, String? activeIcon, double? size}) {
    final Color color = controller.currentIndex.value == index
        ? kBlack
        : kBlack;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customIcon ??
              SvgIcon(
                size: size ?? 25.h,
                controller.currentIndex.value == index
                    ? activeIcon ?? ''
                    : icon ?? '',
                color: color,
              ),
          vSpace(Platform.isIOS ? 2 : 5),
          TextWidget(label, color: color, fontWeight: FontWeight.w500)
        ],
      ),
    );
  }
}
