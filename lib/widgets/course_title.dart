import 'package:amster_app/routes.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CourseTitle extends StatelessWidget {
  const CourseTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.chapterList),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 150.w,
                height: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Image.network(
                  'https://t3.ftcdn.net/jpg/02/04/52/72/360_F_204527293_o9ut8AIm2PaXQg22sSqLMH354X8weheJ.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              hSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Course Name',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: kBlack,
                  ),
                  TextWidget(
                    'instructor : Sabeer ibrahim',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    'videos : 10',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
