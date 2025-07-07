import 'dart:convert';
import 'dart:developer';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:http/http.dart' as http;

class ChapterListController extends GetxController {
  late Course course;

  final chapters = <Chapter>[].obs; // ✅ Declare observable chapter list
  final isLoading = false.obs; // ✅ Declare observable loading state

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Course) {
      course = Get.arguments as Course;
      fetchChapters(); // ✅ Load chapters immediately
    } else {
      log('❗ No course passed to ChapterListController.');
    }
  }

  Future<void> fetchChapters() async {
    isLoading.value = true;
    chapters.clear();

    final token = await LocalStorage().getToken(); // Get the stored JWT token

    for (final chapterId in course.chapters) {
      final url =
          'https://api-amset.vercel.app/api/chapter/$chapterId?courseId=${course.id}';

      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          chapters.add(Chapter.fromJson(data));
        } else {
          log('❌ Failed to load chapter $chapterId — Status: ${response.statusCode}');
        }
      } catch (e) {
        log('❗ Error loading chapter $chapterId: $e');
      }
    }

    isLoading.value = false;
  }
}
