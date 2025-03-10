import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amster_app/widgets/common_widget.dart';

class ChaptersTileWidget extends StatelessWidget {
  const ChaptersTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: 80.w,
          height: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: Image.network(
            'https://t3.ftcdn.net/jpg/02/04/52/72/360_F_204527293_o9ut8AIm2PaXQg22sSqLMH354X8weheJ.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const hSpace(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Budget Analyst',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              TextWidget(
                'Part 1',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        Icon(
          Icons.play_circle_fill,
          color: Colors.green,
          size: 30.w,
        ),
      ],
    );
  }
}
