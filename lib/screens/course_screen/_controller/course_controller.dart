import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    isLoading(true);
    errorMessage('');
    try {
      final token = await localStorage.getToken();
      if (token == null || token.isEmpty) {
        errorMessage('No authentication token found.');
        isLoading(false);
        return;
      }
      final response = await http.get(
        Uri.parse('https://api-amset.vercel.app/api/course'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      log('API Response Status Code: ${response.statusCode}');
      log('API Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final parsed = CourseModel.fromJson(jsonResponse);
        final publishedCourses =
            parsed.courses.where((c) => c.isPublished).toList();
        courses.value = publishedCourses;
      } else {
        errorMessage('Failed to load courses. Status: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
      log(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
