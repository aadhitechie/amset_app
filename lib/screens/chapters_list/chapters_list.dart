import 'package:amster_app/widgets/chapters_tile.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChapterListScreen extends StatelessWidget {
  const ChapterListScreen({super.key});

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
                    Image.network(
                      'https://t3.ftcdn.net/jpg/02/04/52/72/360_F_204527293_o9ut8AIm2PaXQg22sSqLMH354X8weheJ.jpg',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(15.w),
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            'Budget Analyst',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.play_circle_fill,
                            color: Colors.greenAccent,
                            size: 40.w,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const vSpace(20),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext ctx, int index) {
                        return const ChaptersTileWidget();
                      },
                      separatorBuilder: (BuildContext ctx, int index) {
                        return const vSpace(10);
                      },
                      itemCount: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
