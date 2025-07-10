import 'package:amster_app/screens/profile_screen/Options/edit_profile_screen/_model/profile_model.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreenController extends GetxController {
  final Dio _dio = Dio();
  final _storage = LocalStorage();

  final Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool experienceCurrentlyWorking = false.obs;

  // top-level fields
  final fullNameController = TextEditingController();
  final secondaryphoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final postOfficeController = TextEditingController();

  final educationList = <EducationFormData>[].obs;
  final experienceList = <ExperienceFormData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void addEducation() {
    final newEdu = EducationFormData();
    newEdu.isExpanded.value = true;
    educationList.add(newEdu);
  }

  void addExperience() {
    final newExp = ExperienceFormData();
    newExp.isExpanded.value = true;
    experienceList.add(newExp);
  }

  void removeEducation(int index) {
  if (index >= 0 && index < educationList.length) {
    educationList.removeAt(index);
  }
}

void removeExperience(int index) {
  if (index >= 0 && index < experienceList.length) {
    experienceList.removeAt(index);
  }
}

  Future<void> fetchProfile() async {
    isLoading(true);
    errorMessage('');

    try {
      final token = await _storage.getToken();

      final response = await _dio.get(
        'https://api-amset.vercel.app/api/user/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final parsed = ProfileModel.fromJson(response.data);
        profile.value = parsed;

        fullNameController.text = parsed.fullName ?? '';
        secondaryphoneController.text = parsed.secondaryMobileNumber ?? '';

        final address = parsed.address;
        if (address != null) {
          streetController.text = address.street ?? '';
          cityController.text = address.city ?? '';
          districtController.text = address.district ?? '';
          stateController.text = address.state ?? '';
          pinCodeController.text = address.pinCode ?? '';
          countryController.text = address.country ?? '';
          postOfficeController.text = address.postOffice ?? '';
        }

        educationList.clear();
        for (final edu in parsed.education) {
          educationList.add(EducationFormData()
            ..schoolController.text = edu.school ?? ''
            ..degreeController.text = edu.degree ?? ''
            ..fieldOfStudyController.text = edu.fieldOfStudy ?? ''
            ..startDateController.text =
                edu.startDate?.toIso8601String().split('T').first ?? ''
            ..endDateController.text =
                edu.endDate?.toIso8601String().split('T').first ?? ''
            ..gradeController.text = edu.grade ?? ''
            ..descriptionController.text = edu.description ?? '');
        }

        experienceList.clear();
        for (final exp in parsed.experience) {
          experienceList.add(ExperienceFormData()
            ..titleController.text = exp.title ?? ''
            ..companyController.text = exp.company ?? ''
            ..locationController.text = exp.location ?? ''
            ..startDateController.text =
                exp.startDate?.toIso8601String().split('T').first ?? ''
            ..endDateController.text =
                exp.endDate?.toIso8601String().split('T').first ?? ''
            ..currentlyWorking.value = exp.currentlyWorking ?? false
            ..descriptionController.text = exp.description ?? ''
            ..sectorController.text = exp.sector ?? '');
        }
      } else {
        errorMessage.value = 'Failed to fetch profile: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching profile: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfileWithOptionalSections() async {
    isLoading(true);
    errorMessage('');

    try {
      final token = await _storage.getToken();

      final updated = ProfileModel(
        fullName: fullNameController.text,
        secondaryMobileNumber: secondaryphoneController.text,
        address: Address(
          street: streetController.text,
          city: cityController.text,
          district: districtController.text,
          state: stateController.text,
          pinCode: pinCodeController.text,
          country: countryController.text,
          postOffice: postOfficeController.text,
        ),
        education: educationList
            .map((e) => Education(
                  school: e.schoolController.text,
                  degree: e.degreeController.text,
                  fieldOfStudy: e.fieldOfStudyController.text,
                  startDate: e.startDateController.text.isNotEmpty
                      ? DateTime.tryParse(e.startDateController.text)
                      : null,
                  endDate: e.endDateController.text.isNotEmpty
                      ? DateTime.tryParse(e.endDateController.text)
                      : null,
                  grade: e.gradeController.text,
                  description: e.descriptionController.text,
                ))
            .toList(),
        experience: experienceList
            .map((e) => Experience(
                  title: e.titleController.text,
                  company: e.companyController.text,
                  location: e.locationController.text,
                  startDate: e.startDateController.text.isNotEmpty
                      ? DateTime.tryParse(e.startDateController.text)
                      : null,
                  endDate: e.endDateController.text.isNotEmpty
                      ? DateTime.tryParse(e.endDateController.text)
                      : null,
                  currentlyWorking: e.currentlyWorking.value,
                  description: e.descriptionController.text,
                  sector: e.sectorController.text,
                ))
            .toList(),
      );

      final response = await _dio.patch(
        'https://api-amset.vercel.app/api/user/profile',
        data: updated.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        profile.value = ProfileModel.fromJson(response.data);
        Get.snackbar('Success', 'Profile updated');
      } else {
        errorMessage.value = 'Update failed: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Update error: $e';
    } finally {
      isLoading(false);
    }
  }
}

// helper classes
class EducationFormData {
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxBool isExpanded = false.obs;
}

class ExperienceFormData {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final RxBool currentlyWorking = false.obs;
  final RxBool isExpanded = false.obs;
}
