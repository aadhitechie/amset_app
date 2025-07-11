import 'dart:io';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResumePreview extends StatelessWidget {
  final File? image;

  const ResumePreview({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      // borderType: BorderType.BorderType.RRect, // Correct usage of BorderType
      // radius: const Radius.circular(12),
      // dashPattern: const [5, 5],
      // strokeWidth: 2,
      // color: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 130.h,
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_rounded, size: 50.w, color: Colors.grey),
              const SizedBox(height: 10),
              TextWidget(
                "Tap to Choose file",
                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              TextWidget(
                "Supported format: img, jpg, png",
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}