import 'package:get/get.dart';
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart'; // Import JobModel
import 'package:amster_app/services/api_endpoints.dart';
import 'package:amster_app/services/api_service.dart';
import 'package:amster_app/services/api_exception.dart';
import 'package:amster_app/utils/utils.dart';

class HomeController extends GetxController {
  RxBool is_all_job = true.obs;
  RxList<JobModel> jobs = <JobModel>[].obs; // List of all jobs
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs(); // Fetch jobs when the controller is initialized
  }

  // Getter for filtered jobs
  List<JobModel> get filteredJobs {
    if (is_all_job.value) {
      return jobs; // Return all jobs if is_all_job is true
    } else {
      // Implement logic to return saved jobs (e.g., from local storage or another API)
      // For now, let's return an empty list
      return [];
    }
  }

  // Function to fetch jobs from the API
  Future<void> fetchJobs() async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await ApiServices()
          .getMethod(ApiEndpoints.getAllJobs); // Replace with your API endpoint

      if (response.data != null) {
        try {
          List<JobModel> fetchedJobs = (response.data as List)
              .map((job) => JobModel.fromJson(job))
              .toList();
          jobs.value = fetchedJobs;
        } catch (e) {
          errorMessage('Error parsing jobs: ${e.toString()}');
          Utils.showError(ApiException('Error parsing jobs: ${e.toString()}'));
        }
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

  // Function to toggle the is_all_job flag
  void toggleAllJobs(bool value) {
    is_all_job.value = value;
  }
}
