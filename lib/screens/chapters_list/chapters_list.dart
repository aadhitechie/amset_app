import 'package:amster_app/screens/chapters_list/_controller/chapterlist_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/chapters_tile.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:get/get.dart';

class ChapterListScreen extends StatelessWidget {
  ChapterListScreen({super.key});

  final controller = Get.put(ChapterListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_ios_new, size: 25.w),
              ),
              const vSpace(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.course.imageUrl,
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 180.h,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: themeColor,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 180.h,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(controller.course.title,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5),
                          // Icon(
                          //   Icons.play_circle_fill,
                          //   color: themeColor,
                          //   size: 45.w,
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const vSpace(20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: themeColor,
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: controller.chapters.length,
                    separatorBuilder: (context, index) => const vSpace(4),
                    itemBuilder: (context, index) {
                      final chapter = controller.chapters[index];
                      return ChaptersTileWidget(
                        chapter: chapter,
                        index: index,
                        imageUrl: controller.course.imageUrl,
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
