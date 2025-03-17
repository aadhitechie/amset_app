

import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulletList extends StatelessWidget {
  const BulletList(
      {super.key,
      required this.bulletType,
      required this.items,
      this.itemSpacing,
      this.bulletSpacing,
      this.textStyle,
      this.bulletStyle,
      this.bulletWidth,
      this.shrinkWrap = false,
      this.physics,
      this.padding, this.bulletHeight});

  final BulletType bulletType;
  final List<String> items;
  final double? itemSpacing;
  final double? bulletSpacing;
  final TextStyle? textStyle;
  final TextStyle? bulletStyle;
  final double? bulletWidth;
  final double? bulletHeight;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         
          children: [
            SizedBox(
             
              width: bulletWidth,
              height:bulletHeight ,
              child: Center(
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                    style: bulletStyle ?? textStyle ?? const TextStyle(),
                    child: bulletType.builder(index)),
              ),
            ),
            hSpace(bulletSpacing ?? 10.w),
            Expanded(
                child: TextWidget(
              items[index],
              style: textStyle,
            ))
          ],
        );
      },
      separatorBuilder: (context, index) => vSpace(itemSpacing ?? 10.h),
    );
  }
}

class BulletType {
  BulletBuilder builder;

  BulletType._internal({required this.builder});

  factory BulletType.ordered() {
    return BulletType._internal(builder: (index) => TextWidget('${index + 1}'));
  }
  factory BulletType.unordered({String bullet = '●'}) {
    return BulletType._internal(builder: (index) => TextWidget(bullet));
  }
  factory BulletType.custom({required BulletBuilder bulletBuilder}) {
    return BulletType._internal(builder: bulletBuilder);
  }
}

typedef BulletBuilder = Widget Function(int index);
