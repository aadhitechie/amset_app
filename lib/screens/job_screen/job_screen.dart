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
              ),
              const vSpace(10),
              InputField.search(
                onSearch: (val) {
                  // TODO: Implement search functionality
                  log('Search term: $val');
                },
                borderRadius: 20.r,
                hintText: 'search',
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
                      textStyle: TextStyle(
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
                      textStyle: TextStyle(
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
                        child: Text('Error: ${controller.errorMessage.value}'));
                  } else if (controller.filteredJobs.isEmpty) {
                    return const Center(child: Text('No jobs found.'));
                  } else {
                    return ListView.separated(
                      itemCount: controller.filteredJobs.length,
                      separatorBuilder: (context, index) => const vSpace(10),
                      itemBuilder: (context, index) {
                        final job = controller.filteredJobs[index];
                        return JobTileWidget(job: job, key: ValueKey(job.id));
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
