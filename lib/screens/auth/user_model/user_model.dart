// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String message;
  final bool success;
  final String token;
  final User user;

  UserModel({
    required this.message,
    required this.success,
    required this.token,
    required this.user,
  });

  UserModel copyWith({
    String? message,
    bool? success,
    String? token,
    User? user,
  }) {
    return UserModel(
      message: message ?? this.message,
      success: success ?? this.success,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        success: json["success"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String? secondaryMobileNumber;
  final bool hasAllAccess;
  final bool isAdmin;
  final bool deleted;
  final List<String> course;
  final List<String> completedChapters;
  final List<String> savedJobs;
  final List<Experience> experience;
  final List<Education> education;
  final List<dynamic> answers;
  final Address address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image; // Make final
  final int v;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    this.secondaryMobileNumber,
    required this.hasAllAccess,
    required this.isAdmin,
    required this.deleted,
    required this.course,
    required this.completedChapters,
    required this.savedJobs,
    required this.experience,
    required this.education,
    required this.answers,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.v,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? secondaryMobileNumber,
    bool? hasAllAccess,
    bool? isAdmin,
    bool? deleted,
    List<String>? course,
    List<String>? completedChapters,
    List<String>? savedJobs,
    List<Experience>? experience,
    List<Education>? education,
    List<dynamic>? answers,
    Address? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
    int? v,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      secondaryMobileNumber: secondaryMobileNumber ?? this.secondaryMobileNumber,
      hasAllAccess: hasAllAccess ?? this.hasAllAccess,
      isAdmin: isAdmin ?? this.isAdmin,
      deleted: deleted ?? this.deleted,
      course: course ?? this.course,
      completedChapters: completedChapters ?? this.completedChapters,
      savedJobs: savedJobs ?? this.savedJobs,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      answers: answers ?? this.answers,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      v: v ?? this.v,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] ?? '',
        fullName: json['fullName'] ?? '',
        email: json['email'] ?? '',
        mobileNumber: json['mobileNumber'] ?? '',
        secondaryMobileNumber: json['secondaryMobileNumber'],
        hasAllAccess: json['hasAllAccess'] ?? false,
        isAdmin: json['isAdmin'] ?? false,
        deleted: json['deleted'] ?? false,
        course: List<String>.from(json['course'] ?? []),
        completedChapters: List<String>.from(json['completedChapters'] ?? []),
        savedJobs: List<String>.from(json['savedJobs'] ?? []),
        experience: (json['experience'] as List?)
                ?.map((x) => Experience.fromJson(x))
                .toList() ??
            [],
        education: (json['education'] as List?)
                ?.map((x) => Education.fromJson(x))
                .toList() ??
            [],
        answers: json['answers'] ?? [],
        address: Address.fromJson(json['address'] ?? {}),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        image: json["image"] ?? '',
        v: json['__v'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullName': fullName,
        'email': email,
        'mobileNumber': mobileNumber,
        'secondaryMobileNumber': secondaryMobileNumber,
        'hasAllAccess': hasAllAccess,
        'isAdmin': isAdmin,
        'deleted': deleted,
        'course': course,
        'completedChapters': completedChapters,
        'savedJobs': savedJobs,
        'experience': experience.map((x) => x.toJson()).toList(),
        'education': education.map((x) => x.toJson()).toList(),
        'answers': answers,
        'address': address.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        "image": image,
        '__v': v,
      };
}

class Address {
  final String street;
  final String city;
  final String district;
  final String state;
  final String pinCode;
  final String country;
  final String postOffice;

  Address({
    required this.street,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.country,
    required this.postOffice,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'] ?? '',
        city: json['city'] ?? '',
        district: json['district'] ?? '',
        state: json['state'] ?? '',
        pinCode: json['pinCode'] ?? '',
        country: json['country'] ?? '',
        postOffice: json['postOffice'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'district': district,
        'state': state,
        'pinCode': pinCode,
        'country': country,
        'postOffice': postOffice,
      };
}

class Experience {
  final String title;
  final String company;
  final String location;
  final String sector;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool currentlyWorking;
  final String id;

  Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.sector,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.currentlyWorking,
    required this.id,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        title: json['title'] ?? '',
        company: json['company'] ?? '',
        location: json['location'] ?? '',
        sector: json['sector'] ?? '',
        description: json['description'] ?? '',
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        currentlyWorking: json['currentlyWorking'] ?? false,
        id: json['_id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'company': company,
        'location': location,
        'sector': sector,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'currentlyWorking': currentlyWorking,
        '_id': id,
      };
}

class Education {
  final String school;
  final String degree;
  final String fieldOfStudy;
  final String grade;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String id;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.grade,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        school: json['school'] ?? '',
        degree: json['degree'] ?? '',
        fieldOfStudy: json['fieldOfStudy'] ?? '',
        grade: json['grade'] ?? '',
        description: json['description'] ?? '',
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        id: json['_id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'school': school,
        'degree': degree,
        'fieldOfStudy': fieldOfStudy,
        'grade': grade,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        '_id': id,
      };
}
