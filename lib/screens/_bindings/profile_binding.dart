import 'package:amster_app/screens/profile_screen/_controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ProfileBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(ProfileController());
  }
}