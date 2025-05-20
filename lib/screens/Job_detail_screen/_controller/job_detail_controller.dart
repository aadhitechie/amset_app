import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/job_services.dart';
import 'package:amster_app/services/local_storage_service.dart';

class JobDetailController extends GetxController {
  //--------------------------- Reactive State ---------------------------//

  var isApplying = false.obs;
  var alreadyApplied = false.obs;

  var isSaving = false.obs;
  var alreadySaved = false.obs;

  //--------------------------- Lifecycle ---------------------------//

  @override
  void onInit() {
    super.onInit();
    final JobModel job = Get.arguments as JobModel;
    checkIfAlreadyApplied(job.id);
    checkIfAlreadySaved(job.id);
  }

  //--------------------------- Application Status ---------------------------//

  /// Check if user has already applied (local or remote)
  Future<void> checkIfAlreadyApplied(String jobId) async {
    try {
      final locallyApplied = await LocalStorage().isJobApplied(jobId);
      if (locallyApplied) {
        alreadyApplied.value = true;
        return;
      }

      final hasAlreadyApplied = await JobService.hasUserApplied(jobId);
      if (hasAlreadyApplied) {
        alreadyApplied.value = true;
        await LocalStorage().addAppliedJob(jobId);
      }
    } catch (e) {
      log('Error checking if already applied: $e');
      Get.snackbar('Error', 'Failed to check application status: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  //--------------------------- Saved Status ---------------------------//

  /// Check if this job is saved locally
  Future<void> checkIfAlreadySaved(String jobId) async {
    try {
      final locallySaved = await LocalStorage().isJobSaved(jobId);
      if (locallySaved) {
        alreadySaved.value = true;
      }
    } catch (e) {
      log('Error checking if already saved: $e');
    }
  }

  //--------------------------- Apply Action ---------------------------//

  /// Trigger job application through API and local cache
  Future<void> applyToJob(String jobId) async {
    if (alreadyApplied.value) return;

    try {
      isApplying.value = true;
      final success = await JobService.applyToJob(jobId);

      if (success) {
        alreadyApplied.value = true;
        await LocalStorage().addAppliedJob(jobId);

        Get.snackbar('Success', 'Applied to the job successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        alreadyApplied.value = true;
        await LocalStorage().addAppliedJob(jobId);

        Get.snackbar('Info', 'You have already applied for this job',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white);
      }
    } catch (e) {
      log('Error applying to job: $e');
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isApplying.value = false;
    }
  }

  //--------------------------- Save Action ---------------------------//

  /// Trigger job save through API and update UI/local cache
  Future<void> saveJob(String jobId) async {
    if (alreadySaved.value) return;

    try {
      isSaving.value = true;
      final success = await JobService.saveJob(jobId);

      if (success) {
        alreadySaved.value = true;

        await LocalStorage().addSavedJob(jobId);
        await LocalStorage().addSavedJobToUser(jobId);
        Get.find<HomeController>().refreshSavedJobs();

        Get.snackbar('Saved', 'Job saved successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        // API reports "already saved" — treat as success
        alreadySaved.value = true;
        await LocalStorage().addSavedJob(jobId);
      }
    } catch (e) {
      log('Error saving job: $e');
      Get.snackbar('Error', 'Failed to save job: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isSaving.value = false;
    }
  }
}
