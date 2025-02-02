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
    50: AppTheme.primaryColor.withOpacity(0.05),
    100: AppTheme.primaryColor.withOpacity(0.1),
    200: AppTheme.primaryColor.withOpacity(0.2),
    300: AppTheme.primaryColor.withOpacity(0.3),
    400: AppTheme.primaryColor.withOpacity(0.4),
    500: AppTheme.primaryColor.withOpacity(0.5),
    600: AppTheme.primaryColor.withOpacity(0.6),
    700: AppTheme.primaryColor.withOpacity(0.7),
    800: AppTheme.primaryColor.withOpacity(0.8),
    900: AppTheme.primaryColor.withOpacity(0.9),
  };
}
