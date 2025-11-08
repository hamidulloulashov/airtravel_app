import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
class TextFieldPopular extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;

  const TextFieldPopular({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor:  Theme.of(context).appBarTheme.foregroundColor ?? Colors.black,
      style: TextStyle(color:  isDark ? AppColors.grenWhite : AppColors.grey,),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        hintText: hintText,
        hintStyle: TextStyle(color:  Theme.of(context).appBarTheme.foregroundColor ?? Colors.black,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: isDark ? AppColors.grey : AppColors.grenWhite,
      ),
    );
  }
}
