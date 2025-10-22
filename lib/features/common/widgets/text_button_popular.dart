import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextButtonPopular extends StatelessWidget {
  const TextButtonPopular({
    super.key,
    required this.title,
    this.onPressed = _defaultOnPressed,
    this.width = 380,
    this.height = 58,
  });

  final VoidCallback onPressed;
  final String title;
  final int width, height;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.succesGren,
        foregroundColor: AppColors.white,
        fixedSize: Size(width.w, height.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        // style: style,
      ),
    );
  }
}
