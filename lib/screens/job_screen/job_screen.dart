import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/_controller/job_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/job_tile_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';

class JobScreen extends GetWidget<JobController> {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Jobs',
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              const vSpace(10),
              InputField.search(
                onSearch: (val) {
                  controller.updateSearchText(val); // Update search text
                  log('Search term: $val');
                },
                borderRadius: 20.r,
                hintText: 'search',
                textStyle: fontDmSans(letterSpacing: -0.5),
                searchIcon: Icon(
                  Icons.search,
                  size: 28.w,
                ),
              ),
              const vSpace(20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      text: 'All jobs',
                      onPressed: () {
                        controller.isAllJob(true);
                      },
                      backgroundColor:
                          controller.isAllJob.value ? themeColor : kTransparent,
                      textStyle: fontDmSans(
                        letterSpacing: -0.5,
                        color: controller.isAllJob.value ? kWhite : kBlack,
                      ),
                      outlined: true,
                      outlineBorderColor: themeColor,
                      outlineBorderWidth: 2,
                    ),
                    const hSpace(10),
                    PrimaryButton(
                      text: 'Saved jobs',
                      onPressed: () => controller.toggleTab(false),
                      backgroundColor:
                          controller.isAllJob.value ? kTransparent : themeColor,
                      textStyle: fontDmSans(
                        letterSpacing: -0.5,
                        color: controller.isAllJob.value ? kBlack : kWhite,
                      ),
                      outlined: true,
                      outlineBorderColor: themeColor,
                      outlineBorderWidth: 2,
                    ),
                    const hSpace(15),
                  ],
                ),
              ),
              const vSpace(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text('Error: ${controller.errorMessage.value}'),
                    );
                  } else if (controller.filteredJobs.isEmpty) {
                    return const Center(
                      child: TextWidget(
                        'No jobs found.',
                        letterSpacing: -0.5,
                      ),
                    );
                  } else {
                    final jobsToShow = controller.filteredJobs
                        .take(controller.visibleCount.value)
                        .toList();

                    return ListView.separated(
                      itemCount: jobsToShow.length + 1, // add 1 for "View More"
                      separatorBuilder: (context, index) => const vSpace(10),
                      itemBuilder: (context, index) {
                        if (index < jobsToShow.length) {
                          final job = jobsToShow[index];
                          return JobTileWidget(job: job, key: ValueKey(job.id));
                        } else {
                          // Last item → View More or No More
                          if (controller.visibleCount.value <
                              controller.filteredJobs.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Center(
                                child: TextButton(
                                  onPressed: () => controller.loadMoreJobs(),
                                  child: Text(
                                    "View More",
                                    style: fontDmSans(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      //color: themeColor, // green/primary color
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: TextWidget(
                                  "No more jobs",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
