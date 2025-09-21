import 'dart:developer';
import 'package:amster_app/screens/_models/carousel_model.dart';
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
    fetchUserProfile();
    fetchCarouselData();
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
      errorMessage(e.toString());
      Utils.showError(ApiException(' ${e.toString()}'));
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

  /// Fetch user profile from API
  Future<void> fetchUserProfile() async {
    try {
      final response = await ApiServices().getMethod(
          ApiEndpoints.getProfile); // Replace with your actual API endpoint

      if (response.statusCode == 200 && response.data != null) {
        // Assuming the API returns a user object with fullName and image fields
        userFullName.value = response.data['fullName'] ?? 'User';
        userAvatar.value = response.data['image'] ??
            'https://i.pinimg.com/736x/15/0f/a8/150fa8800b0a0d5633abc1d1c4db3d87.jpg'; // Default placeholder

        log("Loaded avatar from API: ${userAvatar.value}");
      } else {
        userFullName.value = 'User';
        userAvatar.value =
            'https://i.pinimg.com/736x/15/0f/a8/150fa8800b0a0d5633abc1d1c4db3d87.jpg';
        log('Failed to load user profile from API');
      }
    } catch (e) {
      userFullName.value = 'User';
      userAvatar.value =
          'https://i.pinimg.com/736x/15/0f/a8/150fa8800b0a0d5633abc1d1c4db3d87.jpg';
      log('Error fetching user profile: $e');
    }
  }

  //--------------------------- Tab Switching ---------------------------//

  /// Switch between 'All Jobs' and 'Saved Jobs'
  void toggleAllJobs(bool value) {
    isAllJob.value = value;
  }

  final RxList<CarouselModel> carouselList = <CarouselModel>[].obs;
  final RxBool isCarouselLoading = false.obs;
  final RxString carouselErrorMessage = ''.obs;

  Future<void> fetchCarouselData() async {
    try {
      isCarouselLoading.value = true;
      carouselErrorMessage.value = '';

      final response = await getCarousel();

      if (response.statusCode == 200) {
        carouselList.clear();

        // Handle different response structures
        dynamic data = response.data;
        List<dynamic> carouselData = [];

        if (data is List) {
          carouselData = data;
        } else if (data is Map && data.containsKey('data')) {
          carouselData = data['data'];
        } else if (data is Map && data.containsKey('carousel')) {
          carouselData = data['carousel'];
        } else {
          carouselData = [data];
        }

        // Convert to CarouselModel objects
        for (var item in carouselData) {
          carouselList.add(CarouselModel.fromJson(item));
        }

        log('Carousel data loaded: ${carouselList.length} items');
      } else {
        carouselErrorMessage.value = 'Failed to load carousel data';
      }
    } catch (e) {
      carouselErrorMessage.value = 'Error loading carousel';
      log('Error fetching carousel: $e');
    } finally {
      isCarouselLoading.value = false;
    }
  }

  // API method to get carousel data
  Future<DioResponse> getCarousel() async {
    return ApiServices(token: false).getMethod(ApiEndpoints.carousel);
  }

  void refreshUserProfile() async {
    final userModel = await _storage.getUser();
    if (userModel != null) {
      userFullName.value = userModel.user.fullName;
      userAvatar.value = userModel.user.image;
      log("Refreshed avatar: ${userAvatar.value}");
    }
  }
}
