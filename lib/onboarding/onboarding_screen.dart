import 'package:amster_app/onboarding/_controller/onboard_controller.dart';
import 'package:amster_app/routes.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends GetWidget<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
                height: 5.w,
                width: double.infinity,
                child: Row(
                  children: List.generate(
                    controller.onboardingData.length,
                    (index) {
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => SizedBox(
                                  height: 5.w,
                                  child: LinearProgressIndicator(
                                      backgroundColor:
                                          kBlack.withAlpha((0.2 * 255).toInt()),
                                      color: kBlack,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                      value: controller.currentPage >= index
                                          ? 1
                                          : 0),
                                ),
                              ),
                            ),
                            if (index < controller.onboardingData.length - 1)
                              const hSpace(3)
                          ],
                        ),
                      );
                    },
                  ),
                )),
            const vSpace(30),
            Expanded(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(controller
                          .onboardingData[controller.currentPage.value]
                          .imagePath),
                    ),

                    Text(
                      controller
                          .onboardingData[controller.currentPage.value].title,
                      style:
                          fontRecoleta(fontSize: 30.sp, color: Colors.black87),
                    ),
                    // Text(
                    //  'amset academy',
                    //   style: fontRecoleta(fontSize: 36.sp, color: themeColor),
                    // ),
                    const vSpace(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: TextWidget(controller
                          .onboardingData[controller.currentPage.value]
                          .subtitle),
                    ),
                    const vSpace(30),
                    Obx(() {
                      return controller.isLastPage()
                          ? PrimaryButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.login);
                              },
                              text: "Get Started",
                              isFullWidth: true,
                              backgroundColor: themeColor,
                            )
                          : PrimaryButton(
                              onPressed: () => controller.nextPage(),
                              text: "Continue",
                              isFullWidth: true,
                              backgroundColor: kBlack,
                            );
                    }),
                    const vSpace(20)
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
