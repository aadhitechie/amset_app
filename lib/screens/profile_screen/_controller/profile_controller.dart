import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxString fullName = ''.obs;
  RxString secondaryMobileNumber = ''.obs;


  TextEditingController secondaryphoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

   final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postOfficeController = TextEditingController();

// Education Controllers
TextEditingController schoolController = TextEditingController();
TextEditingController degreeController = TextEditingController();
TextEditingController fieldOfStudyController = TextEditingController();
TextEditingController eduStartDateController = TextEditingController();
TextEditingController eduEndDateController = TextEditingController();
TextEditingController gradeController = TextEditingController();
TextEditingController eduDescriptionController = TextEditingController();

// Experience Controllers
TextEditingController titleController = TextEditingController();
TextEditingController companyController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController expStartDateController = TextEditingController();
TextEditingController expEndDateController = TextEditingController();
TextEditingController currentlyWorkingController = TextEditingController();
TextEditingController expDescriptionController = TextEditingController();
TextEditingController sectorController = TextEditingController();

  // Address
  RxString street = ''.obs;
  RxString city = ''.obs;
  RxString district = ''.obs;
  RxString state = ''.obs;
  RxString pinCode = ''.obs;
  RxString country = ''.obs;
  RxString postOffice = ''.obs;

  // Education List
  RxList<RxMap<String, dynamic>> education = <RxMap<String, dynamic>>[].obs;

  // Experience List
  RxList<RxMap<String, dynamic>> experience = <RxMap<String, dynamic>>[].obs;
}
