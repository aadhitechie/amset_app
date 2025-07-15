import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/bullet_list.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Text(
              'Terms and Conditions',
              style: fontDmSans(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const vSpace(20),
                TextWidget(
                    "Before using the AMSET app, please read and understand these terms and conditions. By using the app, you agree to comply with these terms. If you do not agree, kindly refrain from using the app.",
                    fontSize: 16.sp,
                    letterSpacing: -0.5),
                const vSpace(24),
                _buildSectionTitle("1. Purpose and Scope"),
                _buildBulletList([
                  "1.1. The AMSET app is operated and managed by AMSET Academy.",
                  "1.2. The AMSET app is not a recruitment company or agency.",
                  "1.3. The app is designed to provide training and guidance to enhance users’ employability skills."
                ]),
                const vSpace(16),
                _buildSectionTitle("2. Services Provided"),
                _buildBulletList([
                  "2.1. AMSET Academy offers specialized training programs to help users improve their job qualifications.",
                  "2.2. The app may provide information on job opportunities and company details; however, the final decision on employment lies solely with the companies or recruitment agencies.",
                  "2.3. AMSET does not guarantee job placement."
                ]),
                const vSpace(16),
                _buildSectionTitle("3. Usage Guidelines"),
                _buildBulletList([
                  "3.1. Users must use the app for lawful purposes and in accordance with AMSET’s policies.",
                  "3.2. All content within the app, including videos, course materials, and certification modules, is the exclusive property of AMSET Academy.",
                  "3.3. Unauthorized copying, sharing, or misuse of AMSET training materials is strictly prohibited and subject to legal action.",
                  "3.4. Attempts to hack, manipulate, or misuse the app will result in immediate termination of access and legal consequences."
                ]),
                const vSpace(16),
                _buildSectionTitle("4. Payment and Refund Policy"),
                _buildBulletList([
                  "4.1. The services provided by the AMSET app are not free.",
                  "4.2. Payments are mandatory for training, certification courses, and access to digital content.",
                  "4.3. Payments made for services are non-refundable under any circumstances.",
                  "4.4. Users are responsible for all costs associated with certifications provided by AMSET."
                ]),
                const vSpace(16),
                _buildSectionTitle("5. Disclaimer of Liability"),
                _buildBulletList([
                  "5.1. AMSET is not responsible for any losses incurred by users or third parties through the use of the app.",
                  "5.2. AMSET is not liable for the authenticity of job opportunities or company details provided in the app. Users are encouraged to verify these independently.",
                  "5.3. AMSET is not responsible for payments demanded by agents or external parties claiming affiliation with the app."
                ]),
                const vSpace(16),
                const TextWidget(
                  "By using the AMSET app, you acknowledge and accept these terms and conditions.",
                  fontSize: 14,
                ),
                const vSpace(50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return TextWidget(title,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: kBlack,
        letterSpacing: -0.5);
  }

  Widget _buildBulletList(List<String> items) {
    return BulletList(
      padding: EdgeInsets.zero,
      bulletType: BulletType.unordered(),
      bulletStyle:
          fontDmSans(fontSize: 4, color: Colors.black, letterSpacing: -0.5),
      bulletSpacing: 5.w,
      bulletHeight: 16.sp,
      shrinkWrap: true,
      textStyle: fontDmSans(fontSize: 16.sp, letterSpacing: -0.5),
      physics: const NeverScrollableScrollPhysics(),
      itemSpacing: 10,
      items: items,
    );
  }
}
