import 'package:amster_app/onboarding/onboarding_screen.dart';
import 'package:amster_app/screens/_bindings/login_binding.dart';
import 'package:amster_app/screens/_bindings/onboarding_binding.dart';
import 'package:amster_app/screens/_bindings/splash_binding.dart';
import 'package:amster_app/screens/auth/login_screen/login_screen.dart';
import 'package:amster_app/screens/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
   static const String login = '/login';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding()
    ),
     GetPage(
        name: Routes.onBoarding,
        page: () => const OnboardingScreen(),
        binding: OnboardingBinding()),
         GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
  ];
}
