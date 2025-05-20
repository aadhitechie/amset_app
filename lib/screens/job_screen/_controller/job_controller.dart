import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/local_storage_service.dart';

class JobController extends GetxController {
  final Dio _dio = Dio();
  final _storage = LocalStorage();

  RxBool isAllJob = true.obs;
  RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobModel> savedJobs = <JobModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

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
        final fetchedJobs = data.map((e) => JobModel.fromJson(e)).toList();
        jobs.value = fetchedJobs;

        await loadSavedJobsFromUser(fetchedJobs);
      } else {
        errorMessage.value =
            'Failed to load jobs. Status code: ${response.statusCode}';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage.value =
            'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      } else {
        errorMessage.value = 'Connection error: ${e.message}';
      }
    } catch (e) {
      errorMessage.value = 'Unexpected error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSavedJobsFromUser(List<JobModel> allJobs) async {
    final userModel = await _storage.getUser();
    if (userModel != null) {
      final savedIds = userModel.user.savedJobs;
      savedJobs.value =
          allJobs.where((job) => savedIds.contains(job.id)).toList();
    } else {
      savedJobs.clear();
    }
  }

  List<JobModel> get filteredJobs {
    return isAllJob.value ? jobs : savedJobs;
  }

  void toggleTab(bool showAll) async {
    isAllJob.value = showAll;
    if (!showAll) {
      await loadSavedJobsFromUser(jobs);
    }
  }
}
