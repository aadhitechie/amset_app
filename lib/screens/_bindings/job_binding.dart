import 'package:amster_app/screens/job_screen/_controller/job_controller.dart';
import 'package:get/get.dart';

class JobBinding extends Bindings {
   @override
  void dependencies() {
    Get.put(JobController());
  }
}