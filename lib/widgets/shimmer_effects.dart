import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

// --- Job Tile Shimmer skeleton ---
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget jobTileShimmer() => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        margin: EdgeInsets.only(bottom: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle for company logo
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.w),
              ),
            ),
            const SizedBox(width: 10),
            // Lines for text fields
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer line
                  Container(
                    width: 120.w,
                    height: 16.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 6.w),
                  // Company name shimmer line
                  Container(
                    width: 80.w,
                    height: 14.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 8.w),
                  // Experience shimmer row
                  Row(
                    children: [
                      Container(
                        width: 14.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        width: 65.w,
                        height: 13.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

// ---Chapter list Shimmer skeleton ---

Widget chapterTileShimmer() => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image shimmer
                Container(
                  width: 90.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                const SizedBox(width: 20),
                // Title/Part shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.sp,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 13.sp,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                // Play icon shimmer (circle)
                Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(left: 100.w),
              child: Divider(
                thickness: 0.8,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );

