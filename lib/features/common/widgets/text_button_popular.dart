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
    this.buttonColor = AppColors.succesGren,
    this.textColor = AppColors.white
  });

  final VoidCallback onPressed;
  final String title;
  final int width, height;
  final Color buttonColor;
  final Color textColor;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:  buttonColor,
        foregroundColor: AppColors.white,
        fixedSize: Size(width.w, height.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
