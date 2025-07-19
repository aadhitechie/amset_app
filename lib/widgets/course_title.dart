import 'package:amster_app/screens/course_screen/_helper/course_purchase_helper.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/routes.dart';

class CourseTitle extends StatelessWidget {
  final Course course;
  const CourseTitle({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Read user's purchased courses from (fresh!) LocalStorage cache
    final userCourses = LocalStorage().getUserSync()?.user.course ?? [];
    final hasPurchased = userCourses.contains(course.id);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: hasPurchased
            ? () => Get.toNamed(Routes.chapterList, arguments: course)
            : null,
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: course.imageUrl,
                  width: 150.w,
                  height: 95.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/png/no_image.jpg', fit: BoxFit.cover),
                ),
              ),
              const hSpace(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      course.title,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      letterSpacing: -0.5,
                    ),
                    TextWidget(
                      'Instructor: ${course.instructor.fullName}',
                      fontSize: 16.sp,
                      letterSpacing: -0.5,
                    ),
                    const vSpace(5),
                    hasPurchased
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[200],
                                foregroundColor: Colors.green[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 7),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Purchased',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: ElevatedButton(
                              onPressed: () => CoursePurchaseHelper.buyCourse(
                                  context, course),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 7),
                                elevation: 2,
                              ),
                              child: TextWidget(
                                'Buy for ₹${course.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
