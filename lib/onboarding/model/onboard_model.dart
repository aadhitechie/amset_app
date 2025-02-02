class OnboardingModel {
  final String title;
  final String subtitle;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imagePath: json['imagePath'],
    );
  }
}
