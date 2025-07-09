import 'package:amster_app/screens/auth/_controller/signup_controller.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(SignupController(),
    permanent: true
    );
  }
}