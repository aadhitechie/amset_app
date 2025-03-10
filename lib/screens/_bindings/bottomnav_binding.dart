import 'package:amster_app/screens/bottom_nav/_controller/bottomnav_controller.dart';
import 'package:amster_app/screens/course_screen/_controller/course_controller.dart';
import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/screens/job_screen/_controller/job_controller.dart';
import 'package:amster_app/screens/profile_screen/_controller/profile_controller.dart';
import 'package:get/get.dart';


class BottomnavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
   Get.put(HomeController());
   Get.put(JobController());
   Get.put(CourseController());
   Get.put(CourseController());
    Get.put(ProfileController());
  }
}
