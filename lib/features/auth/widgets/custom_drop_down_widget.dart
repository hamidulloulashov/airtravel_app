import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropDownWidget({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: isDark ? Colors.grey[850] : Colors.white,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: AppColors.reting,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: isDark ? Colors.grey[850] : AppColors.grenWhite,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: isDark ? Colors.white : Colors.black,
      ),
      validator: validator,
      items: items,
      onChanged: onChanged,
    );
  }
}