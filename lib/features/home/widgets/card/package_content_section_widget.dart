import 'package:airtravel_app/features/home/widgets/card/detail_buttun_widget.dart';
import 'package:airtravel_app/features/home/widgets/card/distation_chips_widget.dart';
import 'package:airtravel_app/features/home/widgets/card/feature_chips_widget.dart';
import 'package:airtravel_app/features/home/widgets/card/pirising_plans_widget.dart';
import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PackageContentSectionWidget extends StatelessWidget {
  final Package package;
  final VoidCallback? onDetailsPressed;

  const PackageContentSectionWidget({
    Key? key,
    required this.package,
    this.onDetailsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(17)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            package.title?.replaceAll(' (uz)', '') ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          DistationChipsWidget(destinations: package.destinations),
          const SizedBox(height: 10),
          Text(
            'Sayohat tarkibi',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          FeatureChipsWidget(coreFeatures: package.coreFeatures),
          const SizedBox(height: 12),
          Text(
            'Tariflar',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          PirisingPlansWidget(plans: package.plans),
          const SizedBox(height: 12),
          DetailButtunWidget(onPressed: onDetailsPressed),
        ],
      ),
    );
  }
}