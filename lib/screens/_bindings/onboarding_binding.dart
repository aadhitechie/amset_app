import 'package:amster_app/onboarding/_controller/onboard_controller.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(OnboardingController());
  }
}