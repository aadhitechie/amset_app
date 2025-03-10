import 'package:amster_app/screens/job_screen/_controller/job_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/job_tile_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              vSpace(10),
              InputField.search(
                onSearch: (val) {},
                borderRadius: 20.r,
                hintText: 'search',
                searchIcon: Icon(
                  Icons.search,
                  size: 28.w,
                ),
              ),
              vSpace(20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      text: 'All jobs',
                      onPressed: () {
                        controller.is_all_job(true);
                      },
                      backgroundColor: controller.is_all_job.value
                          ? themeColor
                          : kTransparent,
                      textStyle: TextStyle(
                        color: controller.is_all_job.value ? kWhite : kBlack,
                      ),
                      outlined: true,
                      outlineBorderColor: themeColor,
                      outlineBorderWidth: 2,
                    ),
                    const hSpace(10),
                    PrimaryButton(
                      text: 'Saved jobs',
                      onPressed: () {
                        controller.is_all_job(false);
                      },
                      backgroundColor: controller.is_all_job.value
                          ? kTransparent
                          : themeColor,
                      textStyle: TextStyle(
                        color: controller.is_all_job.value ? kBlack : kWhite,
                      ),
                      outlined: true,
                      outlineBorderColor: themeColor,
                      outlineBorderWidth: 2,
                    ),
                    const hSpace(15),
                    const hSpace(1),
                    const hSpace(1),
                  ],
                ),
              ),
              vSpace(20),
              Expanded(
                  child: ListView.separated(
                      itemCount: 30,
                      separatorBuilder: (context, index) {
                        return vSpace(10);
                      },
                      itemBuilder: (BuildContext ctx, int index) {
                        return JobTileWidget();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
