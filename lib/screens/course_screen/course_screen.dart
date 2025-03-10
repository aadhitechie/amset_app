import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/course_title.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

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
              'Course',
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
            vSpace(10),
            Expanded(child: ListView.separated(itemBuilder: (BuildContext ctx,int index){
              return CourseTitle();
            }, separatorBuilder: (BuildContext ctx,int index){
              return vSpace(10);
            }, itemCount: 30))
          ],
        ),
      )),
    );
  }
}
