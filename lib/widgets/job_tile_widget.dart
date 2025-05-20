import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:amster_app/routes.dart';
import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/reusable.dart';

class JobTileWidget extends StatelessWidget {
  final JobModel job;

   JobTileWidget({
  required this.job,
  Key? key,
}) : super(key: key ?? ValueKey(job.id)); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.jobDetail, arguments: job),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AvatarWidget(
                    imageUrl: job.companyLogo,
                    size: 50.w,
                  ),
                  const hSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        job.companyName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const vSpace(5),
                      Row(
                        children: [
                          Icon(
                            Icons.business_center,
                            size: 14.w,
                          ),
                          const hSpace(4),
                          Text(
                            job.experienceLevel,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
