import 'package:amster_app/core/theme/primary_button_theme.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/utils/salign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.isDark,
    this.elevation,
    this.outlined,
    this.outlineBorderColor,
    this.outlineBorderWidth,
    this.padding,
    this.showInk = true,
    this.isFullWidth = false,
    this.minHeight = true,
    this.loaderColor,
  }) : child = Text(text, style: textStyle);
  const PrimaryButton.custom({
    super.key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.isDark,
    this.elevation,
    this.outlined,
    this.outlineBorderColor,
    this.outlineBorderWidth,
    this.padding,
    this.showInk = true,
    this.isFullWidth = false,
    this.minHeight = true,
    this.loaderColor,
  })  : text = '',
        textStyle = const TextStyle();
  PrimaryButton.icon({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.isDark,
    required Widget icon,
    SAlign? childAlign,
    double? childSpacing,
    this.elevation,
    this.outlined,
    this.outlineBorderColor,
    this.outlineBorderWidth,
    this.padding,
    this.showInk = true,
    this.isFullWidth = false,
    this.minHeight = true,
    this.loaderColor,
  }) : child = SAlinUtils.buildChildWithAlign(
            w1: icon,
            w2: Text(text, style: textStyle),
            childSpacing: childSpacing,
            childAlign: childAlign);

  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool? isDark;
  final double? elevation;
  final Widget child;
  final bool? outlined;
  final bool showInk;

  final EdgeInsetsGeometry? padding;

  ///to remove taking full width <br>
  ///not applicable when [width] is given
  final bool isFullWidth;

  /// give 'false' for taking minimum height , default height is 50.h<br>
  ///not applicable when [height] is given
  final bool minHeight;

  ///only applicable is [outlined] is true
  final Color? outlineBorderColor;

  ///only applicable is [outlined] is true
  final double? outlineBorderWidth;

  ///loading circularProgressBar color
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    final theme = PrimaryButtonTheme.of(context);
    return SizedBox(
        height: height ?? theme?.height ?? (minHeight ? 40.h : null),
        width: width ?? theme?.width ?? (isFullWidth ? double.infinity : null),
        child: ElevatedButton(
            style: outlined == true
                ? _outlinedButtonStyle(context)
                : _elevatedButtonStyle(context),
            onPressed: isEnabled
                ? isLoading
                    ? () {}
                    : onPressed
                : null,
            child: isLoading
                ? _buildLoading(_getThemeColor(
                    context: context, inverse: outlined ?? false))
                : child));
  }

  Widget _buildLoading(Color color) {
    return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: loaderColor ?? color,
        ));
  }

  ButtonStyle _elevatedButtonStyle(BuildContext context) {
    final theme = PrimaryButtonTheme.of(context);
    return ElevatedButton.styleFrom(
        elevation: elevation ?? theme?.elevation,
        padding: padding ?? theme?.padding,
        minimumSize: Size.zero,
        splashFactory: !showInk ? NoSplash.splashFactory : null,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor:
            backgroundColor ?? theme?.backgroundColor ?? themeColor,
        foregroundColor: _getThemeColor(context: context),
        textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color:
                    kBlack) //please don't change font weight from W600, mostly we have this font weight every where
            .merge(textStyle ?? theme?.textStyle),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? theme?.borderRadius ?? 12.r)));
  }

  ButtonStyle _outlinedButtonStyle(BuildContext context) {
    final theme = PrimaryButtonTheme.of(context);
    return OutlinedButton.styleFrom(
      elevation: elevation ?? theme?.elevation ?? 0,
      padding: padding ?? theme?.padding,
      splashFactory: !showInk ? NoSplash.splashFactory : null,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          color: outlineBorderColor ?? theme?.outlineBorderColor ?? kBlack,
          width: outlineBorderWidth ?? 1.0),
      backgroundColor: backgroundColor ?? kTransparent,
      foregroundColor: _getThemeColor(inverse: true, context: context),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
          .merge(textStyle ?? theme?.textStyle),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? theme?.borderRadius ?? 12.r)),
    );
  }

  Color _getThemeColor({bool inverse = false, required BuildContext context}) {
    final theme = PrimaryButtonTheme.of(context);
    bool dark = isDark ??
        theme?.isDark ??
        Theme.of(context).brightness == Brightness.dark;
    if (inverse) dark = !dark;
    return dark ? Colors.black : Colors.white;
  }
}
