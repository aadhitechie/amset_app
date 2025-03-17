import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ResumeUploadController extends GetxController {
  final _imagePicker = ImagePicker();
  final Rx<File?> resumeImage = Rx<File?>(null);

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        resumeImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void clearImage() {
    resumeImage.value = null;
  }
}