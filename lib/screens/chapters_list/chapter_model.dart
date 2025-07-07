// class ChapterModel {
//   Course? course;

//   ChapterModel({this.course});

//   ChapterModel.fromJson(Map<String, dynamic> json) {
//     course =
//         json['course'] != null ? Course.fromJson(json['course']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (course != null) {
//       data['course'] = course!.toJson();
//     }
//     return data;
//   }
// }

// class Course {
//   String? sId;
//   String? title;
//   bool? isPublished;
//   int? price;
//   bool? deleted;
//   List<Chapters>? chapters;
//   List<dynamic>? purchasedUsers;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? description;
//   String? imageUrl;
//   Instructor? instructor;

//   Course(
//       {this.sId,
//       this.title,
//       this.isPublished,
//       this.price,
//       this.deleted,
//       this.chapters,
//       this.purchasedUsers,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.description,
//       this.imageUrl,
//       this.instructor});

//   Course.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     isPublished = json['isPublished'];
//     price = json['price'];
//     deleted = json['deleted'];
//     if (json['chapters'] != null) {
//       chapters = <Chapters>[];
//       json['chapters'].forEach((v) {
//         chapters!.add(Chapters.fromJson(v));
//       });
//     }
//     if (json['purchasedUsers'] != null) {
//       purchasedUsers = List<dynamic>.from(json['purchasedUsers']);
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     description = json['description'];
//     imageUrl = json['imageUrl'];
//     instructor = json['instructor'] != null
//         ? Instructor.fromJson(json['instructor'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['isPublished'] = isPublished;
//     data['price'] = price;
//     data['deleted'] = deleted;
//     if (chapters != null) {
//       data['chapters'] = chapters!.map((v) => v.toJson()).toList();
//     }
//     // Remove the incorrect mapping of purchasedUsers to v.toJson()
//     if (purchasedUsers != null) {
//       data['purchasedUsers'] = purchasedUsers;
//     }
//     data['description'] = description;
//     data['imageUrl'] = imageUrl;
//     if (instructor != null) {
//       data['instructor'] = instructor!.toJson();
//     }
//     return data;
//   }
// }

// class Chapters {
//   String? sId;
//   String? title;
//   bool? isPublished;
//   List<String>? courses;
//   List<Questions>? questions;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? description;
//   String? notes;

//   Chapters(
//       {this.sId,
//       this.title,
//       this.isPublished,
//       this.courses,
//       this.questions,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.description,
//       this.notes});

//   Chapters.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     isPublished = json['isPublished'];
//     courses = json['courses'].cast<String>();
//     if (json['questions'] != null) {
//       questions = <Questions>[];
//       json['questions'].forEach((v) {
//         questions!.add(Questions.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     description = json['description'];
//     notes = json['notes'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['isPublished'] = isPublished;
//     data['courses'] = courses;
//     if (questions != null) {
//       data['questions'] = questions!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['description'] = description;
//     data['notes'] = notes;
//     return data;
//   }
// }

// class Questions {
//   String? questionText;
//   List<String>? options;
//   int? correctAnswerIndex;
//   String? sId;

//   Questions(
//       {this.questionText, this.options, this.correctAnswerIndex, this.sId});

//   Questions.fromJson(Map<String, dynamic> json) {
//     questionText = json['questionText'];
//     options = json['options'].cast<String>();
//     correctAnswerIndex = json['correctAnswerIndex'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['questionText'] = questionText;
//     data['options'] = options;
//     data['correctAnswerIndex'] = correctAnswerIndex;
//     data['_id'] = sId;
//     return data;
//   }
// }

// class Instructor {
//   String? sId;
//   String? fullName;
//   String? profileImage;
//   String? bio;
//   String? email;
//   String? phone;
//   String? createdAt;
//   int? iV;

//   Instructor(
//       {this.sId,
//       this.fullName,
//       this.profileImage,
//       this.bio,
//       this.email,
//       this.phone,
//       this.createdAt,
//       this.iV});

//   Instructor.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     fullName = json['fullName'];
//     profileImage = json['profileImage'];
//     bio = json['bio'];
//     email = json['email'];
//     phone = json['phone'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['fullName'] = fullName;
//     data['profileImage'] = profileImage;
//     data['bio'] = bio;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['createdAt'] = createdAt;
//     data['__v'] = iV;
//     return data;
//   }
// }
