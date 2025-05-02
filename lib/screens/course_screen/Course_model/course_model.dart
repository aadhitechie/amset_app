// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
    int results;
    List<Course> courses;

    CourseModel({
        required this.results,
        required this.courses,
    });

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        results: json["results"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": results,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    String id;
    String title;
    bool isPublished;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String? description;
    String? category;
    String? imageUrl;
    int? price;
    bool? isPremium;
    bool deleted;
    int? coinsOfRecommend;
    int? vacancyCount;
    List<Learner>? learners;
    List<HiringPartner>? hiringPartners;
    List<String>? chapters;

    Course({
        required this.id,
        required this.title,
        required this.isPublished,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        this.description,
        this.category,
        this.imageUrl,
        this.price,
        this.isPremium,
        required this.deleted,
        this.coinsOfRecommend,
        this.vacancyCount,
        this.learners,
        this.hiringPartners,
        this.chapters,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["_id"],
        title: json["title"],
        isPublished: json["isPublished"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
        category: json["category"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        isPremium: json["isPremium"],
        deleted: json["deleted"],
        coinsOfRecommend: json["coinsOfRecommend"],
        vacancyCount: json["vacancyCount"],
        learners: json["learners"] == null ? [] : List<Learner>.from(json["learners"]!.map((x) => Learner.fromJson(x))),
        hiringPartners: json["hiringPartners"] == null ? [] : List<HiringPartner>.from(json["hiringPartners"]!.map((x) => HiringPartner.fromJson(x))),
        chapters: json["chapters"] == null ? [] : List<String>.from(json["chapters"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "isPublished": isPublished,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "description": description,
        "category": category,
        "imageUrl": imageUrl,
        "price": price,
        "isPremium": isPremium,
        "deleted": deleted,
        "coinsOfRecommend": coinsOfRecommend,
        "vacancyCount": vacancyCount,
        "learners": learners == null ? [] : List<dynamic>.from(learners!.map((x) => x.toJson())),
        "hiringPartners": hiringPartners == null ? [] : List<dynamic>.from(hiringPartners!.map((x) => x.toJson())),
        "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x)),
    };
}

class HiringPartner {
    String companyName;
    String? companyLogo;
    String poster;
    String id;

    HiringPartner({
        required this.companyName,
        this.companyLogo,
        required this.poster,
        required this.id,
    });

    factory HiringPartner.fromJson(Map<String, dynamic> json) => HiringPartner(
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        poster: json["poster"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "companyLogo": companyLogo,
        "poster": poster,
        "_id": id,
    };
}

class Learner {
    String user;
    DateTime joinedOn;
    String id;

    Learner({
        required this.user,
        required this.joinedOn,
        required this.id,
    });

    factory Learner.fromJson(Map<String, dynamic> json) => Learner(
        user: json["user"],
        joinedOn: DateTime.parse(json["joinedOn"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "joinedOn": joinedOn.toIso8601String(),
        "_id": id,
    };
}
