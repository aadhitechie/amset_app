import 'dart:convert';
import 'dart:developer';
import 'package:amster_app/routes.dart';
import 'package:get/get.dart';
import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:amster_app/screens/course_screen/_controller/course_controller.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:amster_app/screens/auth/user_model/user_model.dart';

class CoursePurchaseHelper {
  static Razorpay? _razorpay;

  static String toRazorpayHex(Color color) {
    // Ignore alpha channel for Razorpay
    return '#${color.red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }

  static Future<void> buyCourse(BuildContext context, Course course) async {
    final token = await LocalStorage().getToken();
    final userId = LocalStorage().getUserIdSync();

    if (token == null || token.isEmpty || userId == null) {
      Get.snackbar('Error', 'You must be logged in to buy a course.');
      return;
    }

    try {
      final resp = await http.post(
        Uri.parse('https://api-amset.vercel.app/api/order/initiate'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"courseId": course.id, "userId": userId}),
      );

      final data = jsonDecode(resp.body);
      final order = data['order'] ?? data['data'];

      if (resp.statusCode == 200 && order != null) {
        _startPayment(order, course, userId, token);
      } else {
        Get.snackbar('Order Error', data['error'] ?? 'Could not start order');
      }
    } catch (e) {
      Get.snackbar('Order Error', '$e');
    }
  }

  static void _startPayment(
      Map order, Course course, String userId, String token) {
    _razorpay?.clear();
    _razorpay = Razorpay();

    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, (event) {
      _handlePaymentSuccess(event, course, userId, token);
    });
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, (event) {
      Get.snackbar('Payment Failed', 'Payment error or cancelled');
    });
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, (event) {
      Get.snackbar('Wallet', 'External wallet selected');
    });
    final myColor = Color(0xFF72BF44);
    final hexColor = toRazorpayHex(myColor);
    var options = {
      'key': 'rzp_test_2Pc1OSSjMfuVOK',
      'amount': order['amount'],
      'name': 'Amset App',
      'description': course.title,
      'order_id': order['id'],
      'prefill': {
        'contact': LocalStorage().getUserPhoneSync() ?? '',
        'email': LocalStorage().getUserEmailSync() ?? '',
      },
      'theme': {
        'color': hexColor, // #72BF44
      },
    };

    _razorpay!.open(options);
  }

  static Future<void> _handlePaymentSuccess(
    PaymentSuccessResponse response,
    Course course,
    String userId,
    String token,
  ) async {
    final payload = {
      'razorpay_payment_id': response.paymentId,
      'razorpay_order_id': response.orderId,
      'razorpay_signature': response.signature,
      "courseId": course.id,
      "userId": userId,
    };

    try {
      final verifyResp = await http.post(
        Uri.parse('https://api-amset.vercel.app/api/order/verify'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      final data = jsonDecode(verifyResp.body);

      if (verifyResp.statusCode == 200 &&
          (data['success'] == true ||
              data['message']?.toString().toLowerCase().contains('success') ==
                  true)) {
        Get.snackbar('Success', 'Course purchased!');

        // Refresh courses
        if (Get.isRegistered<CourseController>()) {
          await Get.find<CourseController>().fetchCourses();
        }

        // --- Robust: Refresh user profile and wrap as UserModel ---
        try {
          final freshToken = await LocalStorage().getToken();
          if (freshToken == null || freshToken.isEmpty) return;
          final profileResp = await http.get(
            Uri.parse('https://api-amset.vercel.app/api/user/profile/'),
            headers: {
              'Authorization': 'Bearer $freshToken',
              'Content-Type': 'application/json',
            },
          );
          log('Profile API Status: ${profileResp.statusCode}');
          log('Profile API Body: ${profileResp.body}');
          if (profileResp.statusCode == 200 && profileResp.body.isNotEmpty) {
            final userJson = jsonDecode(profileResp.body);
            if (userJson is Map<String, dynamic> &&
                userJson.containsKey('_id')) {
              final userModel = UserModel(
                message: '',
                success: true,
                token: '',
                user: User.fromJson(userJson),
              );
              await LocalStorage().saveUser(userModel);
              log("User profile updated in local storage after purchase.");
              // ------ Auto-navigate here -------
              Get.toNamed(Routes.chapterList, arguments: course);
            } else {
              log('Profile API did not return a valid user object: $userJson');
            }
          } else {
            log("Failed to update user profile after purchase. Status: ${profileResp.statusCode}, Body: ${profileResp.body}");
          }
        } catch (e, st) {
          log("Error updating user profile after purchase: $e\n$st");
        }
      } else {
        Get.snackbar(
            'Verify Failed', data['error'] ?? 'Could not verify payment.');
      }
    } catch (e) {
      Get.snackbar('Verify Error', 'Could not verify: $e');
    }
  }

  static void dispose() {
    _razorpay?.clear();
  }
}
