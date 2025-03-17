import 'package:amster_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static Color primaryColor = themeColor;
  static ThemeData theme = ThemeData(
      // useMaterial3: true,
      primarySwatch: MaterialColor(primaryColor.value, primarySwatch),
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
          surfaceTintColor: kTransparent, backgroundColor: kTransparent),
      bottomAppBarTheme: const BottomAppBarTheme(color: kWhite));
  static Map<int, Color> primarySwatch = {
    50: AppTheme.primaryColor.withAlpha((0.05 * 225).toInt()),
    100: AppTheme.primaryColor.withAlpha((0.1 * 225).toInt()),
    200: AppTheme.primaryColor.withAlpha((0.2 * 225).toInt()),
    300: AppTheme.primaryColor.withAlpha((0.3 * 225).toInt()),
    400: AppTheme.primaryColor.withAlpha((0.4 * 225).toInt()),
    500: AppTheme.primaryColor.withAlpha((0.5 * 225).toInt()),
    600: AppTheme.primaryColor.withAlpha((0.6 * 225).toInt()),
    700: AppTheme.primaryColor.withAlpha((0.7 * 225).toInt()),
    800: AppTheme.primaryColor.withAlpha((0.8 * 255).toInt()),
    900: AppTheme.primaryColor.withAlpha((0.9 * 255).toInt()),
  };
}
