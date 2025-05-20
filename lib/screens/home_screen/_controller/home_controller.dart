import 'dart:developer';
import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/utils/utils.dart';

class HomeController extends GetxController {
  //--------------------------- Variables ---------------------------//

  final _storage = LocalStorage();

  // UI state
  RxBool isAllJob = true.obs;

  // Data lists
  RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobModel> savedJobs = <JobModel>[].obs;

  // Loading & error state
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // User profile info
  RxString userFullName = ''.obs;
  RxString userAvatar = ''.obs;

  //--------------------------- Lifecycle ---------------------------//

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
    loadUserProfile();
  }

  //--------------------------- Public Getters ---------------------------//

  List<JobModel> get filteredJobs => isAllJob.value ? jobs : savedJobs;

  //--------------------------- Job Fetching ---------------------------//

  /// Fetch all jobs from the server and load saved jobs subset
  Future<void> fetchJobs() async {
    isLoading(true);
    errorMessage('');

    try {
      final response = await ApiServices().getMethod(ApiEndpoints.getAllJobs);

      if (response.data != null) {
        List<JobModel> fetchedJobs = (response.data as List)
            .map((job) => JobModel.fromJson(job))
            .toList();
        jobs.value = fetchedJobs;

        await loadSavedJobsFromUser(fetchedJobs);
      } else {
        errorMessage('No jobs found');
        Utils.showError(const ApiException('No jobs found'));
      }
    } catch (e) {
      errorMessage('Error fetching jobs: ${e.toString()}');
      Utils.showError(ApiException('Error fetching jobs: ${e.toString()}'));
    } finally {
      isLoading(false);
    }
  }

  //--------------------------- Saved Jobs ---------------------------//

  /// Load saved job IDs from user model and map them from full jobs list
  Future<void> loadSavedJobsFromUser(List<JobModel> allJobs) async {
    final userModel = await _storage.getUser();

    if (userModel != null) {
      final savedIds = userModel.user.savedJobs;
      log('Saved Job IDs: $savedIds');

      savedJobs.value =
          allJobs.where((job) => savedIds.contains(job.id)).toList();

      log('Saved Jobs Found: ${savedJobs.length}');
    } else {
      savedJobs.clear();
      log('No user model found when trying to load saved jobs.');
    }
  }

  /// Re-applies saved job filtering (e.g., after saving a new job)
  void refreshSavedJobs() {
    loadSavedJobsFromUser(jobs);
  }

  //--------------------------- User Profile ---------------------------//

  /// Load user full name and avatar from local storage
  void loadUserProfile() async {
    final userModel = await _storage.getUser();

    if (userModel != null) {
      userFullName.value = userModel.user.fullName;
      userAvatar.value = userModel.user.image;
      log("Loaded avatar: ${userAvatar.value}");
    } else {
      userFullName.value = 'User';
      userAvatar.value = '';
    }
  }

  //--------------------------- Tab Switching ---------------------------//

  /// Switch between 'All Jobs' and 'Saved Jobs'
  void toggleAllJobs(bool value) {
    isAllJob.value = value;
  }
}
