import 'package:airtravel_app/features/home/widgets/card/package_content_section_widget.dart';
import 'package:airtravel_app/features/home/widgets/card/packe_image_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PackageCardWidget extends StatelessWidget {
  final Package package;
  final int index;
  final VoidCallback? onDetailsPressed;
  final Function(bool)? onLikeChanged;
  final bool isLiked;

  const PackageCardWidget({
    Key? key,
    required this.package,
    required this.index,
    this.onDetailsPressed,
    this.onLikeChanged,
    this.isLiked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: 320,
      height: 500,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4CAF50),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PackeImageSectionWidget(
            package: package,
            isLiked: isLiked,
            onLikeChanged: onLikeChanged,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: PackageContentSectionWidget(
                package: package,
                onDetailsPressed: onDetailsPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}