import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:dio/dio.dart';

class JobController extends GetxController {
  RxBool isAllJob = true.obs;
  RxList<JobModel> jobs = <JobModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response =
          await _dio.get('https://amset-server.vercel.app/api/job');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        jobs.value = data.map((e) => JobModel.fromJson(e)).toList();
      } else {
        errorMessage.value =
            'Failed to load jobs. Status code: ${response.statusCode}';
        printError(info: errorMessage.value);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage.value =
            'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
        printError(
            info:
                'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
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

  List<JobModel> get filteredJobs {
    if (isAllJob.value) {
      return jobs; // Show all jobs
    } else {
      return jobs.sublist(0, jobs.length);
    }
  }
} 


// List<JobModel> get filteredJobs {
//     if (isAllJob.value) {
//       return jobs; // Show all jobs
//     } else {
//       return jobs.sublist(0, jobs.length > 2 ? 2 : jobs.length);
//     }
//   }
// }
