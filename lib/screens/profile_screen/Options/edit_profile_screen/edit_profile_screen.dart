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
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const vSpace(50),
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
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextWidget('Education', fontSize: 16.sp),
                ]),
                const vSpace(10),

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
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
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
                                            final controller = entry.value;

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
                                                controller: controller,
                                                hintText: hint,
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
                                                          controller.text = picked
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
                              ));
                        }),
                        const vSpace(10),
                        GestureDetector(
                          onTap: controller.addEducation,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.add, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                'Add Education',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),

                const vSpace(30),

                /// EXPERIENCE SECTION
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextWidget('Experience', fontSize: 16.sp),
                ]),
                const vSpace(10),

                const vSpace(10),

                Obx(
                  () => Column(
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
                                            style: TextStyle(fontSize: 14.sp)),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red, size: 20),
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
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
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
                                          final controller = entry.value;

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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: InputField(
                                              controller: controller,
                                              hintText: hint,
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
                                                        controller.text = picked
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
                            ));
                      }),
                      const vSpace(10),
                      GestureDetector(
                        onTap: controller.addExperience,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.add, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              'Add Experience',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget('Currently Working', fontSize: 14.sp),
                    Obx(() => Switch(
                          value: controller.experienceCurrentlyWorking.value,
                          onChanged: (val) =>
                              controller.experienceCurrentlyWorking.value = val,
                        )),
                  ],
                ),

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
      ),
    );
  }
}
