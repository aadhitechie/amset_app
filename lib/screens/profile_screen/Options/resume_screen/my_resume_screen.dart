import 'package:amster_app/screens/profile_screen/Options/resume_screen/_controller/resume_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/resumer_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResumeUploadScreen extends StatelessWidget {
  final ResumeUploadController controller = Get.put(ResumeUploadController());

  ResumeUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: kTransparent,
        centerTitle: true,
        title: TextWidget(
          'Upload Your Resume',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBlack,
            size: 22.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            final resumeImage = controller.resumeImage.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: controller.pickImage,
                  child: ResumePreview(image: resumeImage),
                ),
                if (resumeImage != null)
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image, size: 24.w, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            resumeImage.path,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear_rounded,
                              size: 24.w, color: Colors.grey),
                          onPressed: controller.clearImage,
                        ),
                        SizedBox(width: 8.w),
                        TextButton(
                          onPressed: () {},
                          child: TextWidget(
                            'View',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 32.h),
                PrimaryButton(
                  onPressed: () {},
                  text: 'Upload Resume',
                  textStyle:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  height: 48.h,
                  width: MediaQuery.of(context).size.width / 2,
                  borderRadius: 12.r,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
