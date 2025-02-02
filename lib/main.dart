import 'package:amster_app/core/theme/theme.dart';
import 'package:amster_app/routes.dart';
import 'package:amster_app/utils/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppInitializer.to.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Amset',
            theme: AppTheme.theme,
            getPages: AppPages.pages,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
          );
        });
  }
}
