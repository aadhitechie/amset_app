  import 'package:amster_app/onboarding/model/onboard_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

  class OnboardingController extends GetxController {
     var currentPage = 0.obs;

List<OnboardingModel> onboardingData = [
   OnboardingModel(
    title: 'Get Trained',
    subtitle:
        'Gain experience with expert-led training to build your skills and confidence.',
    imagePath: 'assets/png/course.jpg',
  ),
  OnboardingModel(
    title: 'Get Certified ',
    subtitle:
        'Earn a recognized certification that validates your expertise and enhances your career prospects.',
    imagePath: 'assets/png/bwink_ppl_21_single_01.jpg',
  ),
   OnboardingModel(
    title: 'Secure Job',
    subtitle:
        'Unlock job opportunities with industry-relevant skills and certification support.',
    imagePath: 'assets/png/job.jpg',
  ),
];
void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      currentPage++;
      if (kDebugMode) {
        print(currentPage);
      }
    }
  }
  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
    }
  }
  bool isLastPage() {
    return currentPage.value == onboardingData.length - 1;
  }
  }