class CarouselModel {
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? description;
  final String? link;

  CarouselModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.link,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'] ?? json['imageUrl'],
      description: json['description'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'description': description,
      'link': link,
    };
  }
}