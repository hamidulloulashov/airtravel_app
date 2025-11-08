import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class LanguageOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title $subtitle",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: isDark ? AppColors.grenWhite : AppColors.grey,
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected
                  ? isDark ? AppColors.grenWhite : AppColors.grey
                  : isDark ? AppColors.grenWhite : AppColors.grey,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}