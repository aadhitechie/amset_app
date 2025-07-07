import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/local_storage_service.dart';

class JobController extends GetxController {
  //--------------------------- Dependencies ---------------------------//

  final Dio _dio = Dio();
  final _storage = LocalStorage();

  //--------------------------- Reactive State ---------------------------//

  RxBool isAllJob = true.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobModel> savedJobs = <JobModel>[].obs;

  //--------------------------- Lifecycle ---------------------------//

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  //--------------------------- Data Fetching ---------------------------//

  /// Fetch all jobs from backend and then map saved jobs from local user model
  Future<void> fetchJobs() async {
    isLoading(true);
    errorMessage('');

    try {
      final token = await _storage.getToken();

      if (token == null) {
        errorMessage.value = 'You are not logged in. Please login again.';
        isLoading(false);
        return;
      }

      final response = await _dio.get(
        'https://api-amset.vercel.app/api/job',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

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
      errorMessage.value = e.response != null
          ? 'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}'
          : 'Connection error: ${e.message}';
    } catch (e) {
      errorMessage.value = 'Unexpected error: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  /// Load saved job IDs from the locally stored user model and map them from job list
  Future<void> loadSavedJobsFromUser(List<JobModel> allJobs) async {
    final userModel = await _storage.getUser();

    if (userModel != null) {
      final savedIds =
          userModel.user.savedJobs.map((e) => e.toString()).toList();

      savedJobs.value =
          allJobs.where((job) => savedIds.contains(job.id.toString())).toList();

      log('✅ Saved Jobs Matched: ${savedJobs.length}');
    } else {
      savedJobs.clear();
    }
  }

  //--------------------------- Filtering & UI Toggle ---------------------------//

  /// Get filtered jobs based on current tab selection
  List<JobModel> get filteredJobs => isAllJob.value ? jobs : savedJobs;

  /// Switch between Featured and Saved jobs
  void toggleTab(bool showAll) async {
    isAllJob.value = showAll;
    if (!showAll) {
      await loadSavedJobsFromUser(jobs);
    }
  }
}
