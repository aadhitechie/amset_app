import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/profile_screen/_controller/logout_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
   final LogoutController logoutController = Get.put(LogoutController());

   ProfileScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              'Profile',
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
            const vSpace(50),
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    AvatarWidget(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0ZP9zTf75vBmTD9BJWQmf3DjamXGuvzw44w&s',
                        size: 124.w),
                    const vSpace(10),
                    const TextWidget(
                      'Sabeer Ibrahim',
                      fontWeight: FontWeight.w700,
                    ),
                    const vSpace(40),
                    Container(
                      width: Get.width,
                      height: 50.w,
                      decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                'assets/svg/incomplete.svg',
                                size: 20.w,
                              ),
                              const hSpace(10),
                              TextWidget(
                                'Try resume building for easy apply',
                                fontSize: 13.sp,
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward),
                          //hSpace(15),
                        ],
                      ),
                    )
                  ],
                )),
            const vSpace(30),
            const Column(
              children: [
                ProfileOptions(
                  icon: 'assets/svg/profile-outlined.svg',
                  title: 'Edit profile',
                ),
                vSpace(10),
                ProfileOptions(
                  icon: 'assets/svg/resume.svg',
                  title: 'My resume',
                  route: Routes.resumeUpload,
                ),
                vSpace(10),
                ProfileOptions(
                  icon: 'assets/svg/live.svg',
                  title: 'Live',
                  route: Routes.livePage,
                ),
                vSpace(10),
                ProfileOptions(
                  icon: 'assets/svg/terms.svg',
                  title: 'Terms and conditions',
                  route: Routes.termsAndConditions,
                ),
                vSpace(10),
                ProfileOptions(
                  icon: 'assets/svg/logout.svg',
                  title: 'Logout',
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  SizedBox divider() {
    return SizedBox(
      width: Get.width,
      child: const Divider(color: Colors.grey, thickness: 1.0),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  final String title;
  final String icon;
  final String? route;

  const ProfileOptions({
    super.key,
    required this.title,
    required this.icon,
    this.route,
  });

   @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.find<LogoutController>();

    return GestureDetector(
      onTap: () {
        if (route != null) {
          Get.toNamed(route!);
        } else if (title == 'Logout') {
          logoutController.logout();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgIcon(
                  icon,
                  size: 20.w,
                  color: themeColor,
                ),
                const hSpace(10),
                TextWidget(title, fontSize: 15.sp),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: themeColor,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
