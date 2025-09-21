import 'dart:convert';
import 'dart:developer';

import 'package:amster_app/screens/auth/user_model/user_model.dart';
import 'package:amster_app/screens/home_screen/_controller/home_controller.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final LocalStorage localStorage = LocalStorage();

  /// Form fields
  final formKey = GlobalKey<FormState>();

  RxString fullName = ''.obs;
  RxString secondaryMobileNumber = ''.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController secondaryphoneController =
      TextEditingController();

  /// Profile Image
  RxString imageUrl = ''.obs;

  /// Upload Progress
  RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  /// Load user data from local storage
  Future<void> fetchProfile() async {
    final user = await localStorage.getUser();

    if (user != null) {
      final name = user.user.fullName.trim();
      final image = user.user.image.trim();

      fullName.value = (name.isNotEmpty) ? name : 'No Name';
      imageUrl.value = (image.isNotEmpty)
          ? image
          : 'https://i.pinimg.com/736x/15/0f/a8/150fa8800b0a0d5633abc1d1c4db3d87.jpg';

      fullNameController.text = fullName.value;

      Get.find<HomeController>().refreshUserProfile();

      log("Profile loaded: name=${fullName.value}, image=${imageUrl.value}");
    } else {
      log("No user found in local storage.");
    }
  }

  /// Pick image & upload
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile == null) return;

    isUploading.value = true;

    String? token = await localStorage.getToken();

    if (token == null) {
      Get.snackbar('Error', 'No token found, please login again');
      isUploading.value = false;
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api-amset.vercel.app/api/user/image-upload'),
      );

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        pickedFile.path,
      ));

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      var response = await request.send();

      var body = await response.stream.bytesToString();
      var data = json.decode(body);

      log("Upload response: $data");

      if (response.statusCode == 200) {
        Get.snackbar('Success', data['message'] ?? 'Profile image updated');

        /// fetch fresh profile from server
        await fetchProfileFromServer();
      } else {
        Get.snackbar('Error', 'Unexpected response: ${data.toString()}');
      }
    } catch (e) {
      log("Upload error: $e");
      Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
    } finally {
      isUploading.value = false;
    }
  }

  /// Fetch fresh profile from server and update
  Future<void> fetchProfileFromServer() async {
    try {
      String? token = await localStorage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'No token found');
        return;
      }

      final response = await http.get(
        Uri.parse('https://api-amset.vercel.app/api/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      log("Profile fetch response: ${response.statusCode}");
      log("Profile fetch body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        await localStorage.saveUser(
          UserModel(
            message: '',
            success: true,
            token: token,
            user: User.fromJson(data),
          ),
        );

        await fetchProfile(); // This updates both fullName and image observables

        // Get.snackbar('Success', 'Profile refreshed');
      } else {
        Get.snackbar('Error', 'Failed to refresh profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error refreshing profile: $e');
    }
  }
}
