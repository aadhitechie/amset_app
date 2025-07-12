import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:amster_app/screens/profile_screen/Options/edit_profile_screen/_controller/edit_profile_screen_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';

class EditProfileScreen extends GetWidget<EditProfileScreenController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(children: [
        // 🔷 iOS Back Button Row
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(width: 8.w),
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const vSpace(20),

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
                const vSpace(10),
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
                const vSpace(10),
                const vSpace(10),

                // Address
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
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                    const hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.cityController,
                        borderType: InputFieldBorderType.external,
                        label: 'City',
                        hintText: 'City',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                const vSpace(10),
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
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                    const hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.stateController,
                        borderType: InputFieldBorderType.external,
                        label: 'State',
                        hintText: 'State',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                const vSpace(10),
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
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                    const hSpace(10),
                    Expanded(
                      child: InputField(
                        height: 40.w,
                        controller: controller.postOfficeController,
                        borderType: InputFieldBorderType.external,
                        label: 'Post Office',
                        hintText: 'Post Office',
                        labelStyle: const TextStyle(color: themeColor),
                        textStyle: TextStyle(fontSize: 16.sp),
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        borderColor: kTransparent,
                      ),
                    ),
                  ],
                ),
                const vSpace(10),
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
                const vSpace(30),

                // Title

                /// EDUCATION SECTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget('Education', fontSize: 16.sp),
                        Obx(() => IconButton(
                              icon: Icon(
                                Icons.add,
                                color: controller.noEducation.value
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: controller.noEducation.value
                                  ? null
                                  : controller.addEducation,
                            )),
                      ],
                    ),
                    //        const vSpace(10),
                    Obx(() => Column(
                          children: [
                            ...List.generate(controller.educationList.length,
                                (index) {
                              final edu = controller.educationList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => edu.isExpanded.toggle(),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.grey.shade200,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Education ${index + 1}',
                                                style:
                                                    TextStyle(fontSize: 14.sp)),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red,
                                                      size: 20),
                                                  onPressed: () => controller
                                                      .removeEducation(index),
                                                ),
                                                Icon(
                                                  edu.isExpanded.value
                                                      ? Icons.expand_less
                                                      : Icons.expand_more,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (edu.isExpanded.value)
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 16),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            ...[
                                              edu.schoolController,
                                              edu.degreeController,
                                              edu.fieldOfStudyController,
                                              edu.startDateController,
                                              edu.endDateController,
                                              edu.gradeController,
                                              edu.descriptionController
                                            ].asMap().entries.map((entry) {
                                              final i = entry.key;
                                              final textCtrl = entry.value;

                                              final hint = [
                                                'School',
                                                'Degree',
                                                'Field of Study',
                                                'Start Date (YYYY-MM-DD)',
                                                'End Date (YYYY-MM-DD)',
                                                'Grade',
                                                'Description'
                                              ][i];

                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: InputField(
                                                  controller: textCtrl,
                                                  hintText: hint,
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromARGB(
                                                              255, 83, 82, 82)
                                                          .withOpacity(0.5)),
                                                  borderType:
                                                      InputFieldBorderType.none,
                                                  readOnly: i == 3 || i == 4,
                                                  onTap: (i == 3 || i == 4)
                                                      ? () async {
                                                          final picked =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1970),
                                                            lastDate:
                                                                DateTime(2100),
                                                          );
                                                          if (picked != null) {
                                                            textCtrl.text = picked
                                                                .toIso8601String()
                                                                .split('T')
                                                                .first;
                                                          }
                                                        }
                                                      : null,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                      value: controller.noEducation.value,
                                      onChanged:
                                          controller.educationList.isEmpty
                                              ? (val) {
                                                  controller.noEducation.value =
                                                      val ?? false;
                                                }
                                              : null,
                                    )),
                                Text(
                                  'No History',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),

                const vSpace(30),

                /// EXPERIENCE SECTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget('Experience', fontSize: 16.sp),
                        Obx(() => IconButton(
                              icon: Icon(
                                Icons.add,
                                color: controller.isFresher.value
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: controller.isFresher.value
                                  ? null
                                  : controller.addExperience,
                            )),
                      ],
                    ),
                    // const vSpace(5),
                    Obx(() => Column(
                          children: [
                            ...List.generate(controller.experienceList.length,
                                (index) {
                              final exp = controller.experienceList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => exp.isExpanded.toggle(),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.grey.shade200,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Experience ${index + 1}',
                                                style:
                                                    TextStyle(fontSize: 14.sp)),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red,
                                                      size: 20),
                                                  onPressed: () => controller
                                                      .removeExperience(index),
                                                ),
                                                Icon(
                                                  exp.isExpanded.value
                                                      ? Icons.expand_less
                                                      : Icons.expand_more,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (exp.isExpanded.value)
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 16),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            ...[
                                              exp.titleController,
                                              exp.companyController,
                                              exp.locationController,
                                              exp.startDateController,
                                              exp.endDateController,
                                              exp.descriptionController,
                                              exp.sectorController
                                            ].asMap().entries.map((entry) {
                                              final i = entry.key;
                                              final textCtrl = entry.value;

                                              final hint = [
                                                'Role',
                                                'Company',
                                                'Location',
                                                'Start Date (YYYY-MM-DD)',
                                                'End Date (YYYY-MM-DD)',
                                                'Description',
                                                'Sector'
                                              ][i];

                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: InputField(
                                                  controller: textCtrl,
                                                  hintText: hint,
                                                  hintStyle: TextStyle(
                                                      color: const Color
                                                              .fromARGB(
                                                              255, 83, 82, 82)
                                                          .withOpacity(0.5)),
                                                  borderType:
                                                      InputFieldBorderType.none,
                                                  readOnly: i == 3 || i == 4,
                                                  onTap: (i == 3 || i == 4)
                                                      ? () async {
                                                          final picked =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1970),
                                                            lastDate:
                                                                DateTime(2100),
                                                          );
                                                          if (picked != null) {
                                                            textCtrl.text = picked
                                                                .toIso8601String()
                                                                .split('T')
                                                                .first;
                                                          }
                                                        }
                                                      : null,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                      value: controller.isFresher.value,
                                      onChanged:
                                          controller.experienceList.isEmpty
                                              ? (val) {
                                                  controller.isFresher.value =
                                                      val ?? false;
                                                }
                                              : null,
                                    )),
                                Text(
                                  'I am a Fresher',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextWidget('Currently Working', fontSize: 14.sp),
                //     Obx(() => Switch(
                //           value: controller.experienceCurrentlyWorking.value,
                //           onChanged: (val) =>
                //               controller.experienceCurrentlyWorking.value = val,
                //         )),
                //   ],
                // ),

                const vSpace(50),
                PrimaryButton(
                  text: 'Update',
                  onPressed: () {
                    controller.updateProfileWithOptionalSections();
                  },
                  isFullWidth: true,
                ),
                const vSpace(50),
              ],
            ),
          ),
        ),
      ]),
    )));
    ;
  }
}
