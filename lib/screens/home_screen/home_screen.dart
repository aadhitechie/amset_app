import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/common_appbar.dart';
import 'package:amster_app/widgets/job_tile_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:amster_app/widgets/shimmer_effects.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  HomeScreen({super.key});

  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with dynamic user data
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => commonAppBar(
              greetingText: 'Hi👋',
              nameText: controller.userFullName.value,
              avatar: GestureDetector(
                onTap: () => Get.toNamed(Routes.editProfile),
                child: AvatarWidget(
                  imageUrl: controller.userAvatar.value,
                  size: 50.w,
                ),
              ),
            )),
      ),

      // Main Body as a single scrollable page
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const vSpace(10),

            // Posters section
            Text(
              'Tips for you',
              style: fontDmSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
            const vSpace(20),

            Obx(
              () => Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      viewportFraction: 1.0, // Full width
                      height: 180.h,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        _currentIndex.value = index;
                      },
                    ),
                    items: controller.carouselList
                        .map(
                          (carouselItem) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: carouselItem.imageUrl?.isEmpty ?? true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Image.network(
                                    carouselItem.imageUrl!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 180.h,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        )
                        .toList(),
                  ),

                  // Indicator below carousel
                  const vSpace(8),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.carouselList.asMap().entries.map(
                        (entry) {
                          int idx = entry.key;
                          bool isActive = idx == _currentIndex.value;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: isActive ? 24.0 : 12.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color:
                                  isActive ? themeColor : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: 0,
                                  right: isActive ? 0 : 12.0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
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

            // Job List Section as Column inside SingleChildScrollView
            Obx(() {
              if (controller.isLoading.value) {
                return Column(
                  children: List.generate(4, (_) => jobTileShimmer()),
                );
              } else if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                    child: Text('Error: ${controller.errorMessage.value}'));
              } else if (controller.filteredJobs.isEmpty) {
                return const Center(child: Text('No jobs found.'));
              } else {
                return Column(
                  children: controller.filteredJobs
                      .map((job) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10), // Add desired gap here
                            child: JobTileWidget(job: job),
                          ))
                      .toList(),
                );
              }
            }),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
