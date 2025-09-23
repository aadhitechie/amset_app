import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:amster_app/screens/Job_detail_screen/_controller/job_detail_controller.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/bullet_list.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobModel job = Get.arguments as JobModel;
    final JobDetailController jobController = Get.put(JobDetailController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobController.checkIfAlreadyApplied(job.id);
    });

    log('Job ID in JobDetailScreen: ${job.id}');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Text(
              'Job Details',
              style: fontDmSans(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: job.companyLogo,
                        width: 70.w,
                        height: 70.w,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          width: 70.w,
                          height: 70.w,
                          color: Colors.grey[200],
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 70.w,
                          height: 70.w,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const hSpace(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            job.title,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          const vSpace(4),
                          TextWidget(
                            job.companyName,
                            fontSize: 14.sp,
                            letterSpacing: -0.5,
                            color: Colors.grey[600],
                          ),
                          const vSpace(6),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: Colors.grey),
                              const hSpace(4),
                              Expanded(
                                child: TextWidget(
                                  job.location,
                                  fontSize: 13.sp,
                                  color: Colors.grey[700],
                                  overflow: TextOverflow.ellipsis,
                                  letterSpacing: -0.5,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const vSpace(30),

              _jobInfoTile(Icons.business_center, 'Job Type', job.jobType),
              _jobInfoTile(Icons.lightbulb, 'Experience', job.experienceLevel),
              _jobInfoTile(Icons.attach_money, 'Salary', '\$${job.salary}'),

              const vSpace(20),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const vSpace(16),

              _sectionHeader('Job Description'),
              const vSpace(8),
              TextWidget(
                job.description,
                fontSize: 14.5.sp,
                color: Colors.black87,
                height: 1.6,
              ),

              const vSpace(25),
              _sectionHeader('Requirements'),
              const vSpace(10),
              BulletList(
                padding: EdgeInsets.zero,
                bulletType: BulletType.unordered(),
                bulletStyle: const TextStyle(fontSize: 6, color: Colors.black),
                bulletSpacing: 6.w,
                bulletHeight: 18.sp,
                shrinkWrap: true,
                textStyle: TextStyle(fontSize: 14.sp, color: Colors.black87),
                physics: const NeverScrollableScrollPhysics(),
                itemSpacing: 10,
                items: job.requirements,
              ),

              const vSpace(40),
            ],
          ),
        ),
      ),

      /// Sticky Bottom Buttons
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                final isSaving = jobController.isSaving.value;
                final alreadySaved = jobController.alreadySaved.value;

                return PrimaryButton.icon(
                  text: alreadySaved
                      ? 'Saved'
                      : isSaving
                          ? '⏳ Saving...'
                          : 'Save',
                  isEnabled: !alreadySaved && !isSaving,
                  isLoading: isSaving,
                  onPressed: () {
                    if (!alreadySaved && !isSaving) {
                      jobController.saveJob(job.id);
                    }
                  },
                  icon: const Icon(Icons.bookmark_border, color: kWhite),
                  backgroundColor: alreadySaved
                      ? Colors.grey.shade600
                      : Colors.grey.shade900,
                );
              }),
            ),
            const hSpace(15),
            Expanded(
              child: Obx(() {
                final isApplying = jobController.isApplying.value;
                final alreadyApplied = jobController.alreadyApplied.value;

                return PrimaryButton(
                  text: alreadyApplied
                      ? 'Applied'
                      : isApplying
                          ? '⏳ Applying...'
                          : 'Apply Now',
                  isEnabled: !alreadyApplied && !isApplying,
                  isLoading: isApplying,
                  onPressed: alreadyApplied
                      ? () {}
                      : () {
                          if (!isApplying) {
                            jobController.applyToJob(job.id);
                          }
                        },
                  backgroundColor:
                      alreadyApplied ? Colors.grey.shade600 : Colors.black,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 37.w,
            height: 37.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
            child: Icon(
              icon,
              size: 19.sp,
              color: Colors.green.shade700,
            ),
          ),
          const hSpace(12),
          TextWidget(
            '$label: ',
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
          Expanded(
            child: TextWidget(
              value,
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.ellipsis,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return TextWidget(
      title,
      fontSize: 16.5.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    );
  }
}
