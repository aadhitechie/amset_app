// lib/controllers/razorpay_controller.dart

import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class RazorpayController extends GetxController {
  late Razorpay _razorpay;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({required String name, required String email}) {
    var options = {
      'key': 'rzp_test_cE8SRoaGo1LWRd', // Replace with your Razorpay API key
      'amount': 300000, // Amount in paise (₹3000)
      'name': 'All-Access Pass',
      'description': 'Unlimited access to all courses',
      'prefill': {'contact': '', 'email': email},
      'external': {'wallets': ['paytm']},
      'theme': {'color': '#4f46e5'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Success', 'Payment successful!',
        snackPosition: SnackPosition.BOTTOM);
    // TODO: Verify payment on the server and grant access
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Error', 'Payment failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('Wallet Selected', response.walletName ?? '',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
