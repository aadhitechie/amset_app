
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../screens/auth/_controller/signup_controller.dart';


Widget reUseCountryTextField(
        {required String fieldName,
        required TextEditingController phoneFieldController,
        Color? color,
        // Rx<validators>? isValid,
        // RxString? errorText,
        void Function(PhoneNumber)? onFieldEntry,
        FontWeight? lableWeight = FontWeight.w400,
        Color borderColor = Colors.transparent,
        TextInputType? inputType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters}) =>
    Column(
      children: [
        Row(
          children: [
            //  const hSpace(20),

            TextWidget(
              fieldName,
              style: TextStyle(color: kBlack, fontSize: 12.sp),
            ),
            // const Spacer(),
            // if (isValid != null || errorText != null)
            //   AlertMessage(isValid: isValid!, errorText: errorText!)
          ],
        ),
        const vSpace(10),
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: kWhite,
            border: Border.all(
              color: color ?? lightBlue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SingleChildScrollView(
                  child: Transform.translate(
                    offset: const Offset(0, -10),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                      child: IntlPhoneField(
                        countries: countries,
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: kWhite,
                        ),
                        onChanged: onFieldEntry,
                        disableLengthCheck: false,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.h),
                            errorText: '',
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: const UnderlineInputBorder(),
                            errorStyle: const TextStyle()),
                        dropdownTextStyle:
                            TextStyle(color: kBlack, fontSize: 14.sp),
                        cursorColor: themeColor,
                        showCountryFlag: true,
                        showDropdownIcon: true,
                        style: TextStyle(color: kBlack, fontSize: 14.sp),
                        initialCountryCode:
                            SignupController.to.countryIso.toString(),
                        inputFormatters: inputFormatters,
                        controller: phoneFieldController,
                        onCountryChanged: (country) async {
                          SignupController.to.countryIso.value = country.code;
                          SignupController.to.validatephoneNo = country;
                          SignupController.to.countryCode.value = country.dialCode;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );