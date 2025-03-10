import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_appbar.dart';
import 'package:amster_app/widgets/job_tile_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          greetingText: 'Hi👋',
          nameText: 'Sabeer',
          avatar:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0ZP9zTf75vBmTD9BJWQmf3DjamXGuvzw44w&s',
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const vSpace(10),
            Text(
              'Tips for you',
              style: fontRecoleta(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            const vSpace(20),
            Container(
              clipBehavior: Clip.hardEdge,
              width: Get.width,
              height: 250.w,
              decoration: BoxDecoration(
                  color: kBlack,
                  borderRadius: BorderRadius.all(Radius.circular(30.r))),
              child: Image.asset(
                'assets/png/mm.png',
                fit: BoxFit.cover,
              ),
            ),
            const vSpace(20),
            Text(
              'Job recommendations',
              style: fontRecoleta(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            const vSpace(10),
            Obx(
              () => Row(
               mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrimaryButton(
                    text: 'Featured jobs',
                    onPressed: () {
                      controller.is_all_job(true);
                    },
                    textStyle: TextStyle(color: controller.is_all_job.value ? kWhite : kBlack,),
                    backgroundColor:
                        controller.is_all_job.value ? themeColor : kTransparent,
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
                    backgroundColor:
                        controller.is_all_job.value ? kTransparent : themeColor,
                          textStyle: TextStyle(color: controller.is_all_job.value ? kBlack : kWhite,),
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
            const vSpace(20),
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const vSpace(10);
                    },
                    itemCount: 5,
                    itemBuilder: (BuildContext ctx, int index) {
                      return const JobTileWidget();
                    }))
          ],
        ),
      ),
    );
  }
}
