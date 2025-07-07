import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) =>
    json.encode(data.toJson());

class CourseModel {
  int results;
  List<Course> courses;

  CourseModel({required this.results, required this.courses});

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
  int price;
  bool deleted;
  List<String> chapters; // ❗ chapters are string IDs, not Chapter objects
  List<String> purchasedUsers;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String description;
  String imageUrl;
  Instructor instructor;

  Course({
    required this.id,
    required this.title,
    required this.isPublished,
    required this.price,
    required this.deleted,
    required this.chapters,
    required this.purchasedUsers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.description,
    required this.imageUrl,
    required this.instructor,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["_id"],
        title: json["title"],
        isPublished: json["isPublished"],
        price: json["price"],
        deleted: json["deleted"],
        chapters: List<String>.from(json["chapters"].map((x) => x)),
        purchasedUsers: List<String>.from(json["purchasedUsers"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        instructor: Instructor.fromJson(json["instructor"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "isPublished": isPublished,
        "price": price,
        "deleted": deleted,
        "chapters": List<dynamic>.from(chapters.map((x) => x)),
        "purchasedUsers": List<dynamic>.from(purchasedUsers.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "description": description,
        "imageUrl": imageUrl,
        "instructor": instructor.toJson(),
      };
}

// You only need Chapter and Question classes if another API returns full objects
class Chapter {
  String id;
  String title;
  bool isPublished;
  List<String> courses;
  List<Question> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? description;
  String? notes;
  String? videoUrl;

  Chapter({
    required this.id,
    required this.title,
    required this.isPublished,
    required this.courses,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.description,
    this.notes,
    this.videoUrl,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["_id"],
        title: json["title"],
        isPublished: json["isPublished"],
        courses: List<String>.from(json["courses"].map((x) => x)),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
        notes: json["notes"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "isPublished": isPublished,
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "description": description,
        "notes": notes,
        "videoUrl": videoUrl,
      };
}

class Question {
  String questionText;
  List<String> options;
  int correctAnswerIndex;
  String id;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionText: json["questionText"],
        options: List<String>.from(json["options"].map((x) => x)),
        correctAnswerIndex: json["correctAnswerIndex"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "questionText": questionText,
        "options": List<dynamic>.from(options.map((x) => x)),
        "correctAnswerIndex": correctAnswerIndex,
        "_id": id,
      };
}

class Instructor {
  String id;
  String fullName;
  String profileImage;
  String bio;
  String email;
  String phone;
  DateTime createdAt;
  int v;

  Instructor({
    required this.id,
    required this.fullName,
    required this.profileImage,
    required this.bio,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.v,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["_id"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
        bio: json["bio"],
        email: json["email"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "profileImage": profileImage,
        "bio": bio,
        "email": email,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
