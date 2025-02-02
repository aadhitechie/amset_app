import 'package:amster_app/screens/splash_screen/_controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(SplashController());
  }
}