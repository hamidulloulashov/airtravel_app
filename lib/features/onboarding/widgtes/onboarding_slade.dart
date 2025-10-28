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
          Image.network(data.imagePath),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(data.imagePath),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
  data.title,
  style: const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  textAlign: TextAlign.center,
  maxLines: 2, 
  overflow: TextOverflow.ellipsis, 
  softWrap: true, 
),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String imagePath;
  final bool showAutoLayout;

  OnboardingData({
    required this.title,
    required this.imagePath,
    this.showAutoLayout = false,
  });
}
