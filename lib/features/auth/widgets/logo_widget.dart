import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const LogoWidget({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Image.asset(
      "assets/logo.png",
      width: width ?? 100.w,
      height: height ?? 100.h,
      fit: BoxFit.cover,
      color: isDark ? const Color.fromARGB(255, 46, 46, 46) : const Color.fromARGB(255, 235, 235, 235),
      colorBlendMode: BlendMode.srcIn,
    );
  }
}