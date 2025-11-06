import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class FeatureChipsWidget extends StatelessWidget {
  final List<CoreFeatureModel>? coreFeatures;

  const FeatureChipsWidget({
    Key? key,
    this.coreFeatures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final features = [
      {'icon': Icons.verified_user_outlined, 'label': 'Sug\'urta'},
      {'icon': Icons.receipt_outlined, 'label': 'Ovqat'},
      {'icon': Icons.description_outlined, 'label': 'Visa'},
    ];

    if (coreFeatures != null && coreFeatures!.isNotEmpty) {
      final extraCount = coreFeatures!.length;
      features.add({'icon': Icons.add, 'label': '$extraCount+'});
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
            borderRadius: BorderRadius.circular(16),
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                feature['icon'] as IconData,
                size: 12,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 4),
              Text(
                feature['label'] as String,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}