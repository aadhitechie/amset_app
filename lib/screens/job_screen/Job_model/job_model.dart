// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

List<JobModel> jobModelFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

String jobModelToJson(List<JobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  String id;
  String title;
  String description;
  String companyName;
  String location;
  int salary;
  String jobType;
  String experienceLevel;
  List<String> requirements;
  String companyLogo;
  List<Applicant> applicants;
  int v;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.companyName,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.experienceLevel,
    required this.requirements,
    required this.companyLogo,
    required this.applicants,
    required this.v,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        companyName: json["companyName"],
        location: json["location"],
        salary: json["salary"],
        jobType: json["jobType"],
        experienceLevel: json["experienceLevel"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        companyLogo: json["companyLogo"],
        applicants: List<Applicant>.from(
            json["applicants"].map((x) => Applicant.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "companyName": companyName,
        "location": location,
        "salary": salary,
        "jobType": jobType,
        "experienceLevel": experienceLevel,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "companyLogo": companyLogo,
        "applicants": List<dynamic>.from(applicants.map((x) => x.toJson())),
        "__v": v,
      };
}

class Applicant {
  String applicantId;
  String status;
  String id;

  Applicant({
    required this.applicantId,
    required this.status,
    required this.id,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        applicantId: json["applicantId"],
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "applicantId": applicantId,
        "status": status,
        "_id": id,
      };
}
