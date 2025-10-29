import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingData data;

  const OnboardingSlideWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.network(
                data.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red),
                        SizedBox(height: 8),
                        Text(
                          'Rasmni yuklashda xatolik',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: SingleChildScrollView( // Scroll qilish imkoniyati
                  child: Text(
                    data.prompt,
                    style: const TextStyle(
                      fontSize: 28, // Biroz kichikroq qildim
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.3, // Qatorlar orasidagi masofa
                    ),
                    textAlign: TextAlign.center,
                    // maxLines va overflow ni olib tashladim
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      id: json['id'],
      title: json['title'],
      imagePath: json['picture'],
      prompt: json['prompt'] ?? '',
    );
  }
}