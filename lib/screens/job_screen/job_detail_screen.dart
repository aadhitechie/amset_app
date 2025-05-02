import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/bullet_list.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobModel job = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                    const hSpace(5),
                    Text(
                      'Job Details',
                      style: fontRecoleta(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const vSpace(50),
                Container(
                  width: Get.width,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  child: Row(
                    children: [
                      const hSpace(30),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                          ),
                          child: Image.network(
                            job.companyLogo,
                            width: 50.w,
                            height: 50.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            job.title,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          TextWidget(
                            job.companyName,
                            fontSize: 12.sp,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const vSpace(20),
                TextWidget('Location', fontSize: 12.sp, color: Colors.grey),
                const vSpace(1),
                TextWidget(job.location),
                const vSpace(30),
                TextWidget('Experience', fontSize: 12.sp, color: Colors.grey),
                const vSpace(1),
                TextWidget(job.experienceLevel),
                const vSpace(30),
                TextWidget('Job Nature', fontSize: 12.sp, color: Colors.grey),
                const vSpace(1),
                TextWidget(job.jobType),
                const vSpace(30),
                TextWidget('Salary', fontSize: 12.sp, color: Colors.grey),
                const vSpace(1),
                TextWidget('₹${job.salary}'),
                const vSpace(20),
                SizedBox(
                  width: Get.width,
                  child: const Divider(color: Colors.grey, thickness: 1.0),
                ),
                const vSpace(20),
                TextWidget('Description', fontSize: 15.sp, color: Colors.black),
                const vSpace(10),
                TextWidget(job.description, fontSize: 13.sp),
                const vSpace(20),
                TextWidget('Requirements',
                    fontSize: 15.sp, color: Colors.black),
                const vSpace(10),
                BulletList(
                  padding: EdgeInsets.zero,
                  bulletType: BulletType.unordered(),
                  bulletStyle:
                      const TextStyle(fontSize: 4, color: Colors.black),
                  bulletSpacing: 5.w,
                  bulletHeight: 16.sp,
                  shrinkWrap: true,
                  textStyle: TextStyle(fontSize: 13.sp),
                  physics: const NeverScrollableScrollPhysics(),
                  itemSpacing: 10,
                  items: job.requirements,
                ),
                const vSpace(65)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton.icon(
              text: 'Save',
              onPressed: () {
               
              },
              icon: const Icon(Icons.star_border, color: kWhite),
              backgroundColor: Colors.black87,
            ),
            const hSpace(30),
            PrimaryButton(
              text: 'Apply Now',
              onPressed: () {
              
              },
              backgroundColor: Colors.black87,
            )
          ],
        ),
      ),
    );
  }
}
