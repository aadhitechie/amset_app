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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Job Details',
                  style: fontRecoleta(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                const vSpace(50),
                Container(
                  width: Get.width,
                  height: 80.w,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Row(
                    children: [
                      const hSpace(30),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r))),
                          child: Image.network(
                              'https://store-images.s-microsoft.com/image/apps.30645.9007199266245907.cb06f1f9-9154-408e-b4ef-d19f2325893b.ac3b465e-4384-42a8-9142-901c0405e1bc'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            'Product Designer',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          TextWidget(
                            'Facebook',
                            fontSize: 12.sp,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const vSpace(20),
                TextWidget(
                  'Location',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                const vSpace(1),
                const TextWidget('Dubai'),
                const vSpace(30),
                TextWidget(
                  'Experience',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                const vSpace(1),
                const TextWidget('2-3 Years'),
                const vSpace(30),
                TextWidget(
                  'Job Nature',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                const vSpace(1),
                const TextWidget('Full Time'),
                const vSpace(30),
                TextWidget(
                  'Deadline',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                const vSpace(1),
                const TextWidget('25/12/25'),
                const vSpace(20),
                SizedBox(
                  width: Get.width,
                  child: const Divider(color: Colors.grey, thickness: 1.0),
                ),
                const vSpace(20),
                TextWidget('Description', fontSize: 15.sp, color: Colors.black),
                vSpace(10),
                BulletList(
                    padding: EdgeInsets.zero,
                    bulletType: BulletType.unordered(),
                    bulletStyle: TextStyle(fontSize: 4, color: Colors.black),
                    bulletSpacing: 5.w,
                    bulletHeight: 16.sp,
                    shrinkWrap: true,
                    textStyle: TextStyle(fontSize: 13.sp),
                    physics: const NeverScrollableScrollPhysics(),
                    itemSpacing: 10,
                    items: const [
                      "Responsible for managing a vast digital library of creative assets, including images, videos, and sounds, ensuring their accessibility and organization for internal design teams. Requires strong visual aesthetic, meticulous categorization skills, and proficiency in digital asset management systems.",
                      "Tap on the menu (three horizontal lines).",
                      "And select \"Accounts Center\".",
                      "Tap on \"Your Information and Permissions\".",
                      "Choose \"Download Your Information\".",
                      "Choose \"Download or transfer information\".",
                      "Choose \"Some of your information\".",
                      "Pick the specific types of information you want to import. For example, Content,Stories, Posts, and Short Videos.",
                      "choose \"Download to device\".",
                      "Select \"JSON\" for format.",
                      "Select \"Medium\" for media quality.",
                      "Then click on \"Create files\"",
                      "Once the files are ready, click on \"Download to Device\"",
                      "After downloading the file, click on \"Select import file\" button from VUDE.",
                      "Choose the Instagram import file which starts with \"instagram-\" followed by your Instagram username. And click on Import.",
                      "After successfully importing the files, they will be visible in your profile's import section shortly. Please allow some time for the files to appear.",
                    ]),
                vSpace(50)
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
              onPressed: () {},
              icon: Icon(
                Icons.star_border,
                color: kWhite,
              ),
              backgroundColor: Colors.black87,
            ),
            hSpace(30),
            PrimaryButton(
                text: 'Apply Now',
                onPressed: () {},
                backgroundColor: Colors.black87)
          ],
        ),
      ),
    );
  }
}
