import 'package:amster_app/routes.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  void logout() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget(
                'Logout',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.5),
              ),
              const SizedBox(height: 10),
              const TextWidget(
                'Are you sure you want to logout?',
                letterSpacing: -0.5,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: kGreen,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const TextWidget('Cancel', letterSpacing: -0.5),
                    ),
                  ),

                  const SizedBox(width: 10),
                  // Logout Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        LocalStorage().setSignOut();
                        Get.offAllNamed(Routes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: kGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const TextWidget('Logout', letterSpacing: -0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
