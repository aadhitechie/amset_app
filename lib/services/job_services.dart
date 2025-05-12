import 'dart:developer';
import 'package:amster_app/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobService {
  static final LocalStorage _localStorage = LocalStorage();

// ------------------------- Applu for Job --------------------------//

  static Future<bool> applyToJob(String jobId) async {
    final url =
        Uri.parse('https://amset-server.vercel.app/api/job/apply/$jobId');

    log('Applying to job with ID: $jobId');
    final token = await _localStorage.getToken();
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

      log('Apply Job Response status code: ${response.statusCode}');
      log('Apply Job Response body: ${response.body}');

      if (response.statusCode == 200) {
        log('Successfully applied to job.');
        return true;
      } else if (response.statusCode == 400 &&
          response.body.contains('You have already applied for this job')) {
        log('User has already applied for this job.');
        return false;
      } else {
        log('Failed to apply to job. Status code: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error applying to job: $e');
      return false;
    }
  }

// ------------------------- Checking for applied user --------------------------//

  static Future<bool> hasUserApplied(String jobId) async {
    final url = Uri.parse('https://amset-server.vercel.app/api/job/$jobId');
    final token = await _localStorage.getToken();
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

      log('Check Applied Response status code: ${response.statusCode}');
      log('Check Applied Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['hasApplied'] ?? false;
      } else {
        log('Failed to check if applied. Status code: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error checking if applied: $e');
      return false;
    }
  }

// ------------------------- Save Jobs --------------------------//

  static Future<bool> saveJob(String jobId) async {
    final url =
        Uri.parse('https://amset-server.vercel.app/api/job/save/$jobId');

    log('Saving job with ID: $jobId');
    final token = await _localStorage.getToken();
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

      log('Save Job Response status code: ${response.statusCode}');
      log('Save Job Response body: ${response.body}');

      if (response.statusCode == 200) {
        log('Successfully saved job.');
        return true;
      } else if (response.statusCode == 400 &&
          response.body.contains('already saved')) {
        log('Job already saved.');
        return false;
      } else {
        log('Failed to save job. Status code: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error saving job: $e');
      return false;
    }
  }
}
