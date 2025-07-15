import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/course_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amster_app/widgets/common_widget.dart';

import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amster_app/screens/course_screen/_controller/course_controller.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget('Course',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
              const vSpace(10),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: themeColor,
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }

                  if (controller.courses.isEmpty) {
                    return const Center(child: Text("No courses available."));
                  }

                  return ListView.separated(
                    itemCount: controller.courses.length,
                    separatorBuilder: (_, __) => const vSpace(10),
                    itemBuilder: (context, index) {
                      return CourseTitle(course: controller.courses[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
