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
  List<dynamic> applicants;
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

  factory JobModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedRequirements = [];
    if (json["requirements"] != null) {
      if (json["requirements"] is List) {
        parsedRequirements = (json["requirements"] as List<dynamic>)
            .map<String>((item) => item.toString())
            .toList();
      } else {
        parsedRequirements = [json["requirements"].toString()];
      }
    }

    return JobModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      companyName: json["companyName"],
      location: json["location"],
      salary: json["salary"],
      jobType: json["jobType"],
      experienceLevel: json["experienceLevel"],
      requirements: parsedRequirements,
      companyLogo: json["companyLogo"] is List
          ? (json["companyLogo"].isNotEmpty ? json["companyLogo"][0] : '')
          : json["companyLogo"] ?? '',
      applicants: List<dynamic>.from(json["applicants"].map((x) => x)),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "companyName": companyName,
        "location": location,
        "salary": salary,
        "jobType": jobType,
        "experienceLevel": experienceLevel,
        "requirements": requirements,
        "companyLogo": companyLogo,
        "applicants": List<dynamic>.from(applicants.map((x) => x)),
        "__v": v,
      };
}
