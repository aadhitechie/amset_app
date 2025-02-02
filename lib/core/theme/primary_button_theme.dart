import 'package:flutter/material.dart';

class PrimaryButtonTheme extends InheritedTheme {
  const PrimaryButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static PrimaryButtonThemeData? of(BuildContext context) {
    final PrimaryButtonTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<PrimaryButtonTheme>();

    return inheritedTheme?.data;
    // return inheritedTheme != null
    //     ? inheritedTheme.data
    //     : CustomTheme.of(context)?.primaryButtonTheme;
  }

  final PrimaryButtonThemeData data;
  @override
  bool updateShouldNotify(covariant PrimaryButtonTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return PrimaryButtonTheme(data: data, child: child);
  }
}

class PrimaryButtonThemeData {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool? isDark;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final Color? outlineBorderColor;

  const PrimaryButtonThemeData(
      {this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      this.isDark,
      this.elevation,
      this.textStyle,
      this.outlineBorderColor,
      this.padding});
}
