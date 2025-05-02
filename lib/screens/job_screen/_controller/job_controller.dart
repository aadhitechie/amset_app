import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:dio/dio.dart'; // Import Dio
//import 'package:http/http.dart' as http; // Remove http import

class JobController extends GetxController {
  RxBool isAllJob = true.obs;
  RxList<JobModel> jobs = <JobModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final Dio _dio = Dio(); // Create a Dio instance

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    isLoading.value = true;
    errorMessage.value = ''; // Clear previous error

    try {
      final response =
          await _dio.get('https://amset-server.vercel.app/api/job'); // Use Dio

      if (response.statusCode == 200) {
        final List<dynamic> data =
            response.data; // Access data from Dio response
        jobs.value = data.map((e) => JobModel.fromJson(e)).toList();
      } else {
        errorMessage.value =
            'Failed to load jobs. Status code: ${response.statusCode}';
        printError(info: errorMessage.value);
      }
    } on DioException catch (e) {
      // Catch DioException
      if (e.response != null) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        errorMessage.value =
            'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
        printError(
            info:
                'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        // Something happened in setting up the request that triggered an Error
        errorMessage.value = 'Error connecting to the server: ${e.message}';
        printError(info: 'Error connecting to the server: ${e.message}');
      }
    } catch (e) {
      errorMessage.value = 'Unexpected error: ${e.toString()}';
      printError(info: 'Unexpected error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Getter for filtered jobs based on isAllJob
  List<JobModel> get filteredJobs {
    if (isAllJob.value) {
      return jobs; // Show all jobs
    } else {
      // In a real app, you'd filter based on saved status (e.g., a 'isSaved' property in JobModel)
      // For this example, we'll just return a subset
      return jobs.sublist(0, jobs.length > 2 ? 2 : jobs.length);
    }
  }
}
