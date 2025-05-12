import 'dart:developer';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/job_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class JobDetailController extends GetxController {
  var isApplying = false.obs;
  var alreadyApplied = false.obs;
  var isSaving = false.obs;
  var alreadySaved = false.obs;

  @override
  void onInit() {
    super.onInit();
    final JobModel job = Get.arguments as JobModel;
    checkIfAlreadyApplied(job.id);
    // Optionally: checkIfAlreadySaved(job.id); // if such endpoint exists
  }

  Future<void> checkIfAlreadyApplied(String jobId) async {
    try {
      final hasAlreadyApplied = await JobService.hasUserApplied(jobId);
      alreadyApplied.value = hasAlreadyApplied;
    } catch (e) {
      log('Error checking if already applied: $e');
      Get.snackbar('Error', 'Failed to check application status: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> applyToJob(String jobId) async {
    if (alreadyApplied.value) return;

    try {
      isApplying.value = true;
      final success = await JobService.applyToJob(jobId);

      if (success) {
        alreadyApplied.value = true;
        Get.snackbar('Success', 'Applied to the job successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        alreadyApplied.value = true;
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

  Future<void> saveJob(String jobId) async {
    if (alreadySaved.value) return;

    try {
      isSaving.value = true;
      final success = await JobService.saveJob(jobId);

      if (success) {
        alreadySaved.value = true;
        Get.snackbar('Saved', 'Job saved successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Info', 'Job already saved',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white);
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
