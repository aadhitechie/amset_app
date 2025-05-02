import 'package:amster_app/screens/course_screen/Course_model/course_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    isLoading(true);
    try {
      final response = await http
          .get(Uri.parse('https://amset-server.vercel.app/api/course'));

      if (response.statusCode == 200) {
        final parsed = courseModelFromJson(response.body);
        courses.value = parsed.courses;
      } else {
        Get.snackbar(
            "Error", "Failed to load courses. Status: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
