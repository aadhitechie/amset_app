import 'dart:developer';
import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/utils/utils.dart';

class HomeController extends GetxController {
  final _storage = LocalStorage();

  RxBool is_all_job = true.obs;
  RxList<JobModel> jobs = <JobModel>[].obs;
  RxList<JobModel> savedJobs = <JobModel>[].obs;

  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  RxString userFullName = ''.obs;
  RxString userAvatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
    loadUserProfile();
  }

  List<JobModel> get filteredJobs {
    return is_all_job.value ? jobs : savedJobs;
  }

  //---------------- Load All Jobs from API ----------------//
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

  //---------------- Load Saved Jobs from UserModel ----------------//
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

  //---------------- Toggle Tabs ----------------//
  void toggleAllJobs(bool value) {
    is_all_job.value = value;
  }

  //---------------- Load User Profile ----------------//
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

  void refreshSavedJobs() {
    final currentJobs = jobs;
    loadSavedJobsFromUser(currentJobs);
  }
}
