// lib/screens/_bindings/edit_profile_binding.dart

import 'package:get/get.dart';
import 'package:amster_app/screens/profile_screen/Options/edit_profile_screen/_controller/edit_profile_screen_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileScreenController());
  }
}
