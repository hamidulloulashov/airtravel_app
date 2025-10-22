import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/features/common/widgets/text_button_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/formatter.dart';
import '../../../core/router/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final telefonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 75,
        leading: Center(
          child: IconButton(
            onPressed: () {
              // context.pop();
            },
            icon: SvgPicture.asset(AppIcons.arrowLeft),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 62.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 62.h,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              color: AppColors.grenWhite,
            ),
            Text(
              "Ro‘yxatdan o‘tish",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Column(
              spacing: 23.h,
              children: [
                TextField(
                  controller: telefonController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.containerBlack,
                  inputFormatters: [phoneNumberFormatter],
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      prefixIcon: const Icon(Icons.phone),
                      hintText: "Telefon raqamingizni kiriting",
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: AppColors.grenWhite),
                ),
                TextButtonPopular(
                  title: 'Ro’yxatdan o’tish',
                  onPressed: () {
                    context.push(Routes.verifyCode);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
