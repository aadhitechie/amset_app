import 'package:amster_app/onboarding/onboarding_screen.dart';
import 'package:amster_app/screens/_bindings/bottomnav_binding.dart';
import 'package:amster_app/screens/_bindings/job_binding.dart';
import 'package:amster_app/screens/_bindings/login_binding.dart';
import 'package:amster_app/screens/_bindings/onboarding_binding.dart';
import 'package:amster_app/screens/_bindings/signup_binding.dart';
import 'package:amster_app/screens/_bindings/splash_binding.dart';
import 'package:amster_app/screens/auth/login_screen/login_screen.dart';
import 'package:amster_app/screens/auth/otp/otp_screen.dart';
import 'package:amster_app/screens/auth/signup_screen.dart/signup_screen.dart';
import 'package:amster_app/screens/bottom_nav/bottomnav_screen.dart';
import 'package:amster_app/screens/chapters_list/chapters_list.dart';
import 'package:amster_app/screens/Job_detail_screen/job_detail_screen.dart';
import 'package:amster_app/screens/profile_screen/Options/live_screen/live_screen.dart';
import 'package:amster_app/screens/profile_screen/Options/resume_screen/my_resume_screen.dart';
import 'package:amster_app/screens/profile_screen/Options/terms_and_conditions/terms_and_conditions.dart';
import 'package:amster_app/screens/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomNav = '/bottomNav';
  static const String jobDetail = '/jobDetail';
  static const String chapterList = '/chapterList';
  static const String termsAndConditions = '/termsAndConditions';
  static const String resumeUpload = '/resumeUpload';
  static const String livePage = '/livePage';
  static const String otp = '/otp';
}

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.onBoarding,
        page: () => const OnboardingScreen(),
        binding: OnboardingBinding()),
    GetPage(
        name: Routes.login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: Routes.signup,
        page: () => const SignUpScreen(),
        binding: SignupBinding()),
    GetPage(
        name: Routes.bottomNav,
        page: () => const BottomNavScreen(),
        binding: BottomnavBinding()),
    GetPage(
        name: Routes.jobDetail,
        page: () => const JobDetailScreen(),
        binding: JobBinding()),
    GetPage(
      name: Routes.chapterList,
      page: () => const ChapterListScreen(),
    ),
    GetPage(
      name: Routes.termsAndConditions,
      page: () => const TermsAndConditionsScreen(),
    ),
    GetPage(
      name: Routes.resumeUpload,
      page: () => ResumeUploadScreen(),
    ),
    GetPage(
      name: Routes.livePage,
      page: () => const LiveStreamingPage(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpScreen(),
    )
  ];
}
