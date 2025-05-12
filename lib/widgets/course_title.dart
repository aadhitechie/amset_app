import 'package:cached_network_image/cached_network_image.dart';
import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:amster_app/routes.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';

class CourseTitle extends StatelessWidget {
  final Course course;

  const CourseTitle({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.chapterList, arguments: course),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 150.w,
            height: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CachedNetworkImage(
              imageUrl: course.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200], // Or any other placeholder color
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/png/no_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const hSpace(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  course.title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: kBlack,
                ),
                const vSpace(5),
                TextWidget(
                  'Instructor: Sabeer Ibrahim',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  'Chapters: ${course.chapters?.length ?? 0}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
