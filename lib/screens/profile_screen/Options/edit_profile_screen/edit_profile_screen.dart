import 'package:amster_app/core/theme/theme.dart';
import 'package:amster_app/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:amster_app/screens/profile_screen/Options/edit_profile_screen/_controller/edit_profile_screen_controller.dart';
import 'package:amster_app/utils/constants.dart';
import 'package:amster_app/widgets/common_widget.dart';
import 'package:amster_app/widgets/input_field.dart';
import 'package:amster_app/widgets/primary_button.dart';

class EditProfileScreen extends GetView<EditProfileScreenController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: themeColor,
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${controller.errorMessage.value}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed:
                                controller.fetchProfile, // Retry fetching
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(children: [
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
                          TextWidget(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5),
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
                                labelStyle: const TextStyle(
                                    color: themeColor, letterSpacing: -0.5),
                                hintText: 'Full Name',
                                textStyle: TextStyle(
                                    fontSize: 16.sp, letterSpacing: -0.5),
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    letterSpacing: -0.5),
                                borderColor: kTransparent,
                              ),
                              const vSpace(10),
                              InputField(
                                height: 40.w,
                                controller: controller.secondaryphoneController,
                                borderType: InputFieldBorderType.external,
                                label: 'Secondary Phone',
                                labelStyle: const TextStyle(
                                    color: themeColor, letterSpacing: -0.5),
                                hintText: 'Secondary Phone',
                                textStyle: TextStyle(
                                    fontSize: 16.sp, letterSpacing: -0.5),
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  letterSpacing: -0.5,
                                ),
                                borderColor: kTransparent,

                                // Add these two properties:
                                keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
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
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
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
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
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
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
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
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
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
                                      keyboardType: TextInputType.number,
                                      height: 40.w,
                                      controller: controller.pinCodeController,
                                      borderType: InputFieldBorderType.external,
                                      label: 'PIN Code',
                                      hintText: '110025',
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
                                      borderColor: kTransparent,
                                    ),
                                  ),
                                  const hSpace(10),
                                  Expanded(
                                    child: InputField(
                                      height: 40.w,
                                      controller:
                                          controller.postOfficeController,
                                      borderType: InputFieldBorderType.external,
                                      label: 'Post Office',
                                      hintText: 'Post Office',
                                      labelStyle: const TextStyle(
                                          color: themeColor,
                                          letterSpacing: -0.5),
                                      textStyle: TextStyle(
                                          fontSize: 16.sp, letterSpacing: -0.5),
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          letterSpacing: -0.5),
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
                                labelStyle: const TextStyle(
                                    color: themeColor, letterSpacing: -0.5),
                                textStyle: TextStyle(
                                    fontSize: 16.sp, letterSpacing: -0.5),
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    letterSpacing: -0.5),
                                borderColor: kTransparent,
                              ),
                              const vSpace(30),

                              // Title

                              /// EDUCATION SECTION
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget('Education',
                                          fontSize: 17.sp, letterSpacing: -0.5),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: controller.noEducation.value
                                              ? null
                                              : controller.addEducation,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left:
                                                    8), // space from "Education" text
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 9),
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.noEducation.value
                                                      ? Colors.grey.shade300
                                                      : AppTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                color:
                                                    controller.noEducation.value
                                                        ? Colors.grey.shade700
                                                        : Colors.white,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //        const vSpace(10),
                                  Obx(() => Column(
                                        children: [
                                          ...List.generate(
                                              controller.educationList.length,
                                              (index) {
                                            final edu =
                                                controller.educationList[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        edu.isExpanded.toggle(),
                                                    child: Container(
                                                      width: double.infinity,
                                                      color:
                                                          Colors.grey.shade200,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0,
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextWidget(
                                                              'Education ${index + 1}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  letterSpacing:
                                                                      -0.5)),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 20),
                                                                onPressed: () =>
                                                                    controller
                                                                        .removeEducation(
                                                                            index),
                                                              ),
                                                              Icon(
                                                                edu.isExpanded
                                                                        .value
                                                                    ? Icons
                                                                        .expand_less
                                                                    : Icons
                                                                        .expand_more,
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 16),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.05),
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
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
                                                          ]
                                                              .asMap()
                                                              .entries
                                                              .map((entry) {
                                                            final i = entry.key;
                                                            final textCtrl =
                                                                entry.value;

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
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: InputField(
                                                                controller:
                                                                    textCtrl,
                                                                hintText: hint,
                                                                hintStyle: fontDmSans(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            83,
                                                                            82,
                                                                            82)
                                                                        .withOpacity(
                                                                            0.5),
                                                                    letterSpacing:
                                                                        -0.5),
                                                                borderType:
                                                                    InputFieldBorderType
                                                                        .none,
                                                                readOnly:
                                                                    i == 3 ||
                                                                        i == 4,
                                                                onTap: (i ==
                                                                            3 ||
                                                                        i == 4)
                                                                    ? () async {
                                                                        final picked =
                                                                            await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              DateTime.now(),
                                                                          firstDate:
                                                                              DateTime(1970),
                                                                          lastDate:
                                                                              DateTime(2100),
                                                                        );
                                                                        if (picked !=
                                                                            null) {
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
                                                    value: controller
                                                        .noEducation.value,
                                                    onChanged: controller
                                                            .educationList
                                                            .isEmpty
                                                        ? (val) {
                                                            controller
                                                                    .noEducation
                                                                    .value =
                                                                val ?? false;
                                                          }
                                                        : null,
                                                  )),
                                              TextWidget(
                                                'No History',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    letterSpacing: -0.5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget('Experience',
                                          fontSize: 17.sp, letterSpacing: -0.5),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: controller.isFresher.value
                                              ? null
                                              : controller.addExperience,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left:
                                                    8), // gap between text & button
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 9),
                                            decoration: BoxDecoration(
                                              color: controller.isFresher.value
                                                  ? Colors.grey.shade300
                                                  : AppTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                color:
                                                    controller.isFresher.value
                                                        ? Colors.grey.shade700
                                                        : Colors.white,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const vSpace(5),
                                  Obx(() => Column(
                                        children: [
                                          ...List.generate(
                                              controller.experienceList.length,
                                              (index) {
                                            final exp = controller
                                                .experienceList[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        exp.isExpanded.toggle(),
                                                    child: Container(
                                                      width: double.infinity,
                                                      color:
                                                          Colors.grey.shade200,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 0,
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextWidget(
                                                              'Experience ${index + 1}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  letterSpacing:
                                                                      -0.5)),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 20),
                                                                onPressed: () =>
                                                                    controller
                                                                        .removeExperience(
                                                                            index),
                                                              ),
                                                              Icon(
                                                                exp.isExpanded
                                                                        .value
                                                                    ? Icons
                                                                        .expand_less
                                                                    : Icons
                                                                        .expand_more,
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 16),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.05),
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
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
                                                          ]
                                                              .asMap()
                                                              .entries
                                                              .map((entry) {
                                                            final i = entry.key;
                                                            final textCtrl =
                                                                entry.value;

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
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: InputField(
                                                                controller:
                                                                    textCtrl,
                                                                hintText: hint,
                                                                hintStyle: TextStyle(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            83,
                                                                            82,
                                                                            82)
                                                                        .withOpacity(
                                                                            0.5),
                                                                    letterSpacing:
                                                                        -0.5),
                                                                borderType:
                                                                    InputFieldBorderType
                                                                        .none,
                                                                readOnly:
                                                                    i == 3 ||
                                                                        i == 4,
                                                                onTap: (i ==
                                                                            3 ||
                                                                        i == 4)
                                                                    ? () async {
                                                                        final picked =
                                                                            await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              DateTime.now(),
                                                                          firstDate:
                                                                              DateTime(1970),
                                                                          lastDate:
                                                                              DateTime(2100),
                                                                        );
                                                                        if (picked !=
                                                                            null) {
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
                                                    value: controller
                                                        .isFresher.value,
                                                    onChanged: controller
                                                            .experienceList
                                                            .isEmpty
                                                        ? (val) {
                                                            controller.isFresher
                                                                    .value =
                                                                val ?? false;
                                                          }
                                                        : null,
                                                  )),
                                              TextWidget(
                                                'I am a Fresher',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    letterSpacing: -0.5),
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
                                  controller
                                      .updateProfileWithOptionalSections();
                                },
                                isFullWidth: true,
                              ),
                              const vSpace(50),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  }
                }))));
  }
}
