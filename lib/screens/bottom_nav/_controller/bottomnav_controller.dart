import 'package:amster_app/screens/course_screen/course_screen.dart';
import 'package:amster_app/screens/home_screen/home_screen.dart';
import 'package:amster_app/screens/job_screen/job_screen.dart';
import 'package:amster_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  RxInt currentIndex = 0.obs;

  final List<Widget> children = [
    const HomeScreen(),
    const JobScreen(),
    CourseScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    currentIndex.value = index;
  }
}
