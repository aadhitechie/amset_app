import 'package:amster_app/screens/Chapter%20Player/Chapter_detail_page.dart';
import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';

class ChaptersTileWidget extends StatelessWidget {
  final Chapter chapter;
  final int index;
  final String imageUrl;

  const ChaptersTileWidget({
    super.key,
    required this.chapter,
    required this.index,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.to(() => const ChapterDetailPage(), arguments: {
          'title': chapter.title,
          'description': chapter.description ?? 'No description available.',
          'videoUrl': chapter.videoUrl ?? '',
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 80.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const hSpace(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(chapter.title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.5),
                  TextWidget('Part ${index + 1}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5),
                ],
              ),
            ),
            Icon(
              Icons.play_circle_fill,
              color: Colors.green,
              size: 30.w,
            ),
          ],
        ),
      ),
    );
  }
}
