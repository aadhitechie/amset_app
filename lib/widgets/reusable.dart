import 'package:amster_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

Widget annotedRegionLightIcon({required Widget child, Color? statusBarColor}) =>
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: child,
    );

// ignore: camel_case_types
class hSpace extends StatelessWidget {
  const hSpace(this.width, {super.key});
  final double width;
  @override
  Widget build(BuildContext context) => SizedBox(width: width.w);
}

// ignore: camel_case_types
class vSpace extends StatelessWidget {
  const vSpace(this.height, {super.key});
  final double height;
  @override
  Widget build(BuildContext context) => SizedBox(height: height.h);
}

//-----------------------Fonts-------------------------------
TextStyle fontRecoleta(
    {Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing}) {
  return TextStyle(
    fontFamily: 'Recoleta',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
  );
}

Widget makeScrollable({required Widget child}) {
  return CustomScrollView(
    slivers: [
      SliverFillRemaining(
        child: child,
      )
    ],
  );
}
//-----------------------others-------------------------------

Widget gradientShader({Gradient? gradient, required Widget child}) {
  return ShaderMask(
    shaderCallback: (rect) => (gradient ??
            const LinearGradient(
                colors: [themeColor, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight))
        .createShader(rect),
    child: child,
  );
}

Widget loadingWidget() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget loadingOverlay(
    {required RxBool loading, Widget? loadingWidget, required Widget child}) {
  return Obx(
    () => Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (loading.value) ...[
          const Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: Colors.black)),
          loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              )
        ]
      ],
    ),
  );
}