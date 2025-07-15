import 'package:amster_app/routes.dart';
import 'package:amster_app/screens/profile_screen/_controller/logout_controller.dart';
import 'package:amster_app/screens/profile_screen/_controller/profile_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/avatar_widget.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
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
              TextWidget('Profile',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
              const vSpace(50),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Column(
                    children: [
                      Stack(
                        children: [
                          AvatarWidget(
                            imageUrl: controller.imageUrl.value.isNotEmpty
                                ? controller.imageUrl.value
                                : 'https://i.pinimg.com/736x/15/0f/a8/150fa8800b0a0d5633abc1d1c4db3d87.jpg',
                            size: 124.w,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.pickAndUploadImage(),
                              child: CircleAvatar(
                                radius: 18.w,
                                backgroundColor: themeColor,
                                child: controller.isUploading.value
                                    ? SizedBox(
                                        width: 18.w,
                                        height: 18.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        Icons.camera_alt,
                                        size: 18.w,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const vSpace(10),
                      TextWidget(
                        controller.fullName.value,
                        letterSpacing: -0.5,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      const vSpace(40),
                      Container(
                        width: Get.width,
                        height: 50.w,
                        decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                        ),
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
                                TextWidget('Try resume building for easy apply',
                                    fontSize: 15.sp, letterSpacing: -0.5),
                              ],
                            ),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const vSpace(30),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.editProfile),
                    child: Container(
                      color: kTransparent,
                      child: const ProfileOptions(
                        icon: 'assets/svg/profile-outlined.svg',
                        title: 'Edit profile',
                        route: Routes.editProfile,
                      ),
                    ),
                  ),
                  const vSpace(10),
                  const ProfileOptions(
                    icon: 'assets/svg/live.svg',
                    title: 'Live',
                    route: Routes.livePage,
                  ),
                  const vSpace(10),
                  const ProfileOptions(
                    icon: 'assets/svg/terms.svg',
                    title: 'Terms and conditions',
                    route: Routes.termsAndConditions,
                  ),
                  const vSpace(10),
                  ProfileOptions(
                    icon: 'assets/svg/logout.svg',
                    title: 'Logout',
                    onTap: () => logoutController.logout(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  final String title;
  final String icon;
  final String? route;
  final VoidCallback? onTap;

  const ProfileOptions({
    super.key,
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else if (route != null) {
          Get.toNamed(route!);
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
                TextWidget(title, fontSize: 15.sp, letterSpacing: -0.5),
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
