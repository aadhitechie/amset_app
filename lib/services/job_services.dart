import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:amster_app/screens/job_screen/Job_model/job_model.dart';
import 'package:amster_app/services/local_storage_service.dart';

class JobService {
  static final LocalStorage _localStorage = LocalStorage();

  //--------------------------- Apply for Job ---------------------------//

  static Future<bool> applyToJob(String jobId) async {
    final token = await _localStorage.getToken();
    final url = Uri.parse('https://api-amset.vercel.app/api/job/apply/$jobId');

    log('Applying to job with ID: $jobId');

    if (token == null || token.isEmpty) {
      log('Error: No authentication token found.');
      return false;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log('Apply Job Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        log('Successfully applied to job.');
        return true;
      } else if (response.statusCode == 400 &&
          response.body.contains('You have already applied for this job')) {
        log('User has already applied for this job.');
        return false;
      } else {
        log('Failed to apply. Status: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception while applying: $e');
      return false;
    }
  }

  //--------------------------- Check Application Status ---------------------------//

  static Future<bool> hasUserApplied(String jobId) async {
    final token = await _localStorage.getToken();
    final url = Uri.parse('https://api-amset.vercel.app/api/job/$jobId');

    if (token == null || token.isEmpty) {
      log('Error: No authentication token found.');
      return false;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log('Check Applied Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['hasApplied'] ?? false;
      } else {
        log('Check failed. Status: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception while checking application: $e');
      return false;
    }
  }

  //--------------------------- Save Job ---------------------------//

  static Future<bool> saveJob(String jobId) async {
    final token = await _localStorage.getToken();
    final url = Uri.parse('https://api-amset.vercel.app/api/job/save/$jobId');

    if (token == null || token.isEmpty) return false;

    try {
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      log('Save Job Response: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      log('Exception while saving job: $e');
      return false;
    }
  }

  //--------------------------- Fetch Job by ID ---------------------------//

  static Future<JobModel?> fetchJobById(String jobId) async {
    final token = await _localStorage.getToken();
    final url = Uri.parse('https://api-amset.vercel.app/api/job/$jobId');

    if (token == null || token.isEmpty) return null;

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return JobModel.fromJson(data['job']); // Adjust key if necessary
      }

      log('Failed to fetch job. Status: ${response.statusCode}');
      return null;
    } catch (e) {
      log('Exception while fetching job by ID: $e');
      return null;
    }
  }
}
