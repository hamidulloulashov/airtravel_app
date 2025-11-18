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
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      picture: json['picture'] ?? '',
      prompt: json['prompt'] ?? '',
    );
  }
}

class OnboardingData {
  final int id;
  final String? title;
  final String imagePath;
  final String prompt;
  final bool showAutoLayout;

  OnboardingData({
    required this.id,
    this.title,
    required this.imagePath,
    required this.prompt,
    this.showAutoLayout = false,
  });

  factory OnboardingData.fromJson(Map<String, dynamic> json) {
    return OnboardingData(
      id: json['id'] ?? 0,
      title: json['title'],  
      imagePath: json['picture'] ?? '',
      prompt: json['prompt'] ?? '',
      showAutoLayout: json['showAutoLayout'] ?? false,
    );
  }
}