import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class BuildNotificationTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BuildNotificationTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          color:  isDark ? AppColors.grenWhite : AppColors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Switch.adaptive(
        activeThumbColor: isDark ? AppColors.grey : AppColors.grenWhite,
        activeTrackColor: isDark ? AppColors.grenWhite : AppColors.grey,
        value: value,
        onChanged: onChanged,
        inactiveThumbColor:  isDark ? AppColors.grenWhite : AppColors.grey,
        inactiveTrackColor:  isDark ? AppColors.grenWhite : AppColors.grey,
      ),
    );
  }
}
