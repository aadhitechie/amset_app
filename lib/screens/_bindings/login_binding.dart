import 'package:amster_app/screens/auth/_controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(Logincontroller());
  }
}