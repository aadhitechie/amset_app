import 'package:amster_app/screens/profile_screen/_controller/profile_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class EditProfileScreen extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Full Name
                 vSpace(50),
                InputField(
                  height: 40.w,
                  controller: controller.fullNameController,
                  borderType: InputFieldBorderType.external,
                  label: 'Full Name',
                  labelStyle: const TextStyle(color: themeColor),
                  hintText: 'Full Name',
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),

                // Secondary Phone
                InputField(
                  height: 40.w,
                  controller: controller.secondaryphoneController,
                  borderType: InputFieldBorderType.external,
                  label: 'Secondary Phone',
                  labelStyle: const TextStyle(color: themeColor),
                  hintText: 'Secondary Phone',
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                
                ),
                vSpace(10),

                // Address Row 1: Street + City
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.streetController,
                        borderType: InputFieldBorderType.external,
                        label: 'Street',
                        hintText: 'Street',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                    hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.cityController,
                        borderType: InputFieldBorderType.external,
                        label: 'City',
                        hintText: 'City',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                vSpace(10),

                // Address Row 2: District + State
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.districtController,
                        borderType: InputFieldBorderType.external,
                        label: 'District',
                        hintText: 'District',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                    hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.stateController,
                        borderType: InputFieldBorderType.external,
                        label: 'State',
                        hintText: 'State',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                vSpace(10),

                // Pin + Post Office
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.pinCodeController,
                        borderType: InputFieldBorderType.external,
                        label: 'PIN Code',
                        hintText: '110025',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                       
                      ),
                    ),
                    hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.postOfficeController,
                        borderType: InputFieldBorderType.external,
                        label: 'Post Office',
                        hintText: 'Post Office',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                vSpace(10),

                // Country
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Country',
                  hintText: 'India',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                  vSpace(40),
                  TextWidget('Education'),
                  vSpace(10),
                   InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'School',
                  hintText: 'School',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                 InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Degree',
                  hintText: 'Degree',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Field Of Study',
                  hintText: 'Field',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                GestureDetector(
                  onTap: (){
                    print('hello')
;                  }
  //                 WeekPicker(
  //     selectedDate: selectedDate,
  //     onChanged: onNewSelected,
  //     firstDate: firstAllowedDate,
  //     lastDate: lastAllowedDate,
  //     datePickerStyles: styles
  // )
  ,
                  child: InputField(
                    height: 40.w,
                    controller: controller.countryController,
                    borderType: InputFieldBorderType.external,
                    label: 'Start Of Date',
                    hintText: 'Start Of Date',
                    labelStyle: const TextStyle(color: themeColor),
                    textStyle: TextStyle(fontSize: 16.sp),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    borderColor: kTransparent,
                    readOnly: true,
                  ),
                ),
                 vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'End Of Date',
                  hintText: 'End Of Date',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Grade',
                  hintText: 'Grade',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                 vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Description',
                  hintText: 'Description',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                 vSpace(40),
                 TextWidget('Experience'),
                 vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Role',
                  hintText: 'Role',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Company',
                  hintText: 'Company',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Location',
                  hintText: 'Location',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget('Start Date',fontSize: 12.sp,),
                  ],
                ),
                Container(),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'End Date',
                  hintText: 'End Date',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Currently Working',
                  hintText: 'Yes/No',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Description',
                  hintText: 'Description',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(10),
                InputField(
                  height: 40.w,
                  controller: controller.countryController,
                  borderType: InputFieldBorderType.external,
                  label: 'Sector',
                  hintText: 'Sector',
                  labelStyle: const TextStyle(color: themeColor),
                  textStyle: TextStyle(fontSize: 16.sp),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  borderColor: kTransparent,
                ),
                vSpace(50),
                PrimaryButton(text: 'Update', onPressed: (){

                },
                isFullWidth: true,),
                 vSpace(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
