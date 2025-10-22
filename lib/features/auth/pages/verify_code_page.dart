import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../common/widgets/text_button_popular.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kodni kiriting",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 128.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 128.h,
          children: [
            Column(
              spacing: 80.h,
              children: [
                Text("Sms kodini kiriting"),
                Pinput(
                  controller: controller,
                  length: 4,
                  keyboardType: TextInputType.number,
                  // obscureText: true,
                  // obscuringWidget: Icon(Icons.ac_unit_outlined),
                  defaultPinTheme: PinTheme(
                    width: 83.w,
                    height: 61.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.grenWhite,
                    ),
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 83.w,
                    height: 61.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.succesGren, width: 1.5),
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.grenWhite,
                    ),
                    textStyle: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            TextButtonPopular(
              title: 'Tasdiqlash',
              onPressed: () {
                context.push(Routes.profileInfo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
