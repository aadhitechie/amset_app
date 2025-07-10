class ProfileModel {
  String? fullName;
  String? secondaryMobileNumber;
  Address? address;
  List<Education> education;
  List<Experience> experience;

  ProfileModel({
    this.fullName,
    this.secondaryMobileNumber,
    this.address,
    List<Education>? education,
    List<Experience>? experience,
  })  : education = education ?? [],
        experience = experience ?? [];

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'],
      secondaryMobileNumber: json['secondaryMobileNumber'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      education: (json['education'] as List?)?.map((e) => Education.fromJson(e)).toList(),
      experience: (json['experience'] as List?)?.map((e) => Experience.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'secondaryMobileNumber': secondaryMobileNumber,
      'address': address?.toJson(),
      'education': education.map((e) => e.toJson()).toList(),
      'experience': experience.map((e) => e.toJson()).toList(),
    };
  }
}


class Address {
  String? street;
  String? city;
  String? district;
  String? state;
  String? pinCode;
  String? country;
  String? postOffice;

  Address({
    this.street,
    this.city,
    this.district,
    this.state,
    this.pinCode,
    this.country,
    this.postOffice,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      pinCode: json['pinCode'],
      country: json['country'],
      postOffice: json['postOffice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'district': district,
      'state': state,
      'pinCode': pinCode,
      'country': country,
      'postOffice': postOffice,
    };
  }
}

class Education {
  String? school;
  String? degree;
  String? fieldOfStudy;
  DateTime? startDate;
  DateTime? endDate;
  String? grade;
  String? description;

  Education({
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.grade,
    this.description,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      school: json['school'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      startDate: json['startDate'] != null ? DateTime.tryParse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      grade: json['grade'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'school': school,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'grade': grade,
      'description': description,
    };
  }
}

class Experience {
  String? title;
  String? company;
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  bool? currentlyWorking;
  String? description;
  String? sector;

  Experience({
    this.title,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.description,
    this.sector,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      company: json['company'],
      location: json['location'],
      startDate: json['startDate'] != null ? DateTime.tryParse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      currentlyWorking: json['currentlyWorking'],
      description: json['description'],
      sector: json['sector'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'currentlyWorking': currentlyWorking,
      'description': description,
      'sector': sector,
    };
  }
}
