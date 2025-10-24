class OnboardingModel {
  final int id;
  final String title;
  final String picture;
  final String prompt;

  OnboardingModel({
    required this.id,
    required this.title,
    required this.picture,
    required this.prompt,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      id: json['id'],
      title: json['title'],
      picture: json['picture'],
      prompt: json['prompt'] ?? '',
    );
  }
}
