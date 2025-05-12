// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String message;
    bool success;
    String token;
    User user;

    UserModel({
        required this.message,
        required this.success,
        required this.token,
        required this.user,
    });

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
    String id;
    String username;
    String email;
    String mobileNumber;
    bool isAdmin;
    int v;
    List<dynamic> courses;
    DateTime updatedAt;
    String image;
    String address;
    String district;
    String fullName;
    String postOffice;
    String pinCode;
    String secondaryMobileNumber;
    List<Answer> answers;
    List<String> completedChapters;
    List<CourseCoin> courseCoins;
    bool deleted;
    String bioDescription;
    bool hasAllAccess;
    List<String> savedJobs;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.mobileNumber,
        required this.isAdmin,
        required this.v,
        required this.courses,
        required this.updatedAt,
        required this.image,
        required this.address,
        required this.district,
        required this.fullName,
        required this.postOffice,
        required this.pinCode,
        required this.secondaryMobileNumber,
        required this.answers,
        required this.completedChapters,
        required this.courseCoins,
        required this.deleted,
        required this.bioDescription,
        required this.hasAllAccess,
        required this.savedJobs,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        isAdmin: json["isAdmin"],
        v: json["__v"],
        courses: List<dynamic>.from(json["courses"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image: json["image"],
        address: json["address"],
        district: json["district"],
        fullName: json["fullName"],
        postOffice: json["postOffice"],
        pinCode: json["pinCode"],
        secondaryMobileNumber: json["secondaryMobileNumber"],
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        completedChapters: List<String>.from(json["completedChapters"].map((x) => x)),
        courseCoins: List<CourseCoin>.from(json["courseCoins"].map((x) => CourseCoin.fromJson(x))),
        deleted: json["deleted"],
        bioDescription: json["bioDescription"],
        hasAllAccess: json["hasAllAccess"],
        savedJobs: List<String>.from(json["savedJobs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "mobileNumber": mobileNumber,
        "isAdmin": isAdmin,
        "__v": v,
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image,
        "address": address,
        "district": district,
        "fullName": fullName,
        "postOffice": postOffice,
        "pinCode": pinCode,
        "secondaryMobileNumber": secondaryMobileNumber,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "completedChapters": List<dynamic>.from(completedChapters.map((x) => x)),
        "courseCoins": List<dynamic>.from(courseCoins.map((x) => x.toJson())),
        "deleted": deleted,
        "bioDescription": bioDescription,
        "hasAllAccess": hasAllAccess,
        "savedJobs": List<dynamic>.from(savedJobs.map((x) => x)),
    };
}

class Answer {
    String chapterId;
    String courseId;
    List<UserAnswer> userAnswers;
    String id;

    Answer({
        required this.chapterId,
        required this.courseId,
        required this.userAnswers,
        required this.id,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        chapterId: json["chapterId"],
        courseId: json["courseId"],
        userAnswers: List<UserAnswer>.from(json["userAnswers"].map((x) => UserAnswer.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "courseId": courseId,
        "userAnswers": List<dynamic>.from(userAnswers.map((x) => x.toJson())),
        "_id": id,
    };
}

class UserAnswer {
    String questionId;
    int selectedOptionIndex;
    String id;

    UserAnswer({
        required this.questionId,
        required this.selectedOptionIndex,
        required this.id,
    });

    factory UserAnswer.fromJson(Map<String, dynamic> json) => UserAnswer(
        questionId: json["questionId"],
        selectedOptionIndex: json["selectedOptionIndex"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "selectedOptionIndex": selectedOptionIndex,
        "_id": id,
    };
}

class CourseCoin {
    String courseId;
    int coins;
    String id;

    CourseCoin({
        required this.courseId,
        required this.coins,
        required this.id,
    });

    factory CourseCoin.fromJson(Map<String, dynamic> json) => CourseCoin(
        courseId: json["courseId"],
        coins: json["coins"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "coins": coins,
        "_id": id,
    };
}
