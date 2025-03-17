import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Utils {
  Utils._();

  //-----------------------Snackbar-------------------------------
  static showError(Object? e, {String? title}) {
    ApiException exception;
    if (e == null) {
      exception = ApiException.default_;
    } else {
      exception = e is ApiException
          ? e
          : kDebugMode
              ? ApiException('$e', title: 'Unhandled exception')
              : ApiException.default_;
    }
  }

  static showSuccess(String message,
      {String? title, Widget? icon, Duration? duration}) {
    snackBar(
        title: title,
        message: message,
        icon: icon ??
            Icon(
              Icons.check_circle,
              color: themeColor,
              size: 18.w,
            ),
        duration: duration,
        indicatorColor: themeColor);
  }

  static snackBar(
      {required String message,
      Widget? icon,
      Color? indicatorColor,
      String? title,
      Color? backgroundColor,
      Duration? duration,
      Duration? animationDuration,
      SnackPosition position = SnackPosition.BOTTOM,
      Widget? action}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.transparent,
      snackPosition: position,
      duration: duration ?? const Duration(seconds: 3),
      animationDuration: animationDuration ?? const Duration(seconds: 1),
      messageText: IntrinsicHeight(
        child: Container(
          // type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          //borderRadius: BorderRadius.circular(10.r),
          // elevation: 4,
          decoration: BoxDecoration(
            color: const Color(0xff08140E),
            border: Border.all(color: const Color(0xff244B31), width: 1),
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: Row(
            children: [
              // if (indicatorColor != null)
              //   VerticalDivider(
              //     color: indicatorColor,
              //     thickness: 5,
              //     width: 5,
              //   ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.w),
                  child: Row(
                    children: [
                      if (icon != null) ...[icon, const hSpace(14)],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (title != null) ...[
                              TextWidget(
                                title,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              const vSpace(5),
                            ],
                            TextWidget(
                              message,
                              fontSize: 11.sp,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      action ?? const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
