import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_appbar.dart';
import 'package:amster_app/widgets/job_tile_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with dynamic user data
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => commonAppBar(
              greetingText: 'Hi👋',
              nameText: controller.userFullName.value,
              avatar: controller.userAvatar.value.isNotEmpty
                  ? controller.userAvatar.value
                  : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0ZP9zTf75vBmTD9BJWQmf3DjamXGuvzw44w&s',
            )),
      ),

      // Main Body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const vSpace(10),

            // Posters go here
            Text(
              'Tips for you',
              style: fontDmSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
            const vSpace(20),

            const vSpace(20),
            Obx(
              () => CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                ),
                items: controller.carouselList
                    .map((carouselItem) => Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                          ),
                          child: Center(
                            child: (carouselItem.imageUrl?.isEmpty ?? true)
                                ? CircularProgressIndicator()
                                : Image.network(
                                    carouselItem.imageUrl!,
                                    fit: BoxFit.cover,
                                    width: Get.width,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const CircularProgressIndicator();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image,
                                            size: 50, color: Colors.grey),
                                      );
                                    },
                                  ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const vSpace(20),
            Text(
              'Job recommendations',
              style: fontDmSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const vSpace(10),

            // Tab Buttons: Featured | Saved
            Obx(
              () => Row(
                children: [
                  PrimaryButton(
                    text: 'Featured jobs',
                    onPressed: () {
                      controller.isAllJob(true);
                    },
                    textStyle: fontDmSans(
                      letterSpacing: -0.5,
                      color: controller.isAllJob.value ? kWhite : kBlack,
                    ),
                    backgroundColor:
                        controller.isAllJob.value ? themeColor : kTransparent,
                    outlined: true,
                    outlineBorderColor: themeColor,
                    outlineBorderWidth: 2,
                  ),
                  const hSpace(10),
                  PrimaryButton(
                    text: 'Saved jobs',
                    onPressed: () {
                      controller.toggleAllJobs(false);
                      controller.loadSavedJobsFromUser(controller.jobs);
                    },
                    textStyle: fontDmSans(
                      letterSpacing: -0.5,
                      color: controller.isAllJob.value ? kBlack : kWhite,
                    ),
                    backgroundColor:
                        controller.isAllJob.value ? kTransparent : themeColor,
                    outlined: true,
                    outlineBorderColor: themeColor,
                    outlineBorderWidth: 2,
                  ),
                ],
              ),
            ),

            const vSpace(20),

            // Job List Section
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${controller.errorMessage.value}'));
                } else if (controller.filteredJobs.isEmpty) {
                  return const Center(child: Text('No jobs found.'));
                } else {
                  return ListView.separated(
                    itemCount: controller.filteredJobs.length,
                    separatorBuilder: (context, index) => const vSpace(10),
                    itemBuilder: (context, index) {
                      final job = controller.filteredJobs[index];
                      return JobTileWidget(job: job);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
