import 'package:airtravel_app/features/common/widgets/text_button_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import '../../../core/client.dart';
import '../widgets/language_otp_button_widget.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'uz';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language_code') ?? 'uz';
    });
  }

  Future<void> _saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {'title': "O'zbek", 'subtitle': '(Uz)', 'value': 'uz'},
      {'title': 'English', 'subtitle': '(En)', 'value': 'en'},
      {'title': 'Русский', 'subtitle': '(Ru)', 'value': 'ru'},
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final isDark = Theme.of(context).appBarTheme.foregroundColor == Brightness.dark;
    return Scaffold(
      appBar: AppBarWidget(
        showThemeToggle: true,
        title: 'Language',
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 15.h, bottom: 5.h),
            child: Text(
              'Tavsiya etilgan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: isDark ? AppColors.grenWhite : AppColors.grey,
              ),
            ),
          ),
          ...languages.map((lang) {
            return LanguageOptionTile(
              title: lang['title']!,
              subtitle: lang['subtitle']!,
              isSelected: _selectedLanguage == lang['value'],
              onTap: () async {
                setState(() {
                  _selectedLanguage = lang['value']!;
                });
                await _saveLanguage(lang['value']!);
                ApiClient.updateLanguage(lang['value']!);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    width: double.infinity,
                    height: 300.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 70.h,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Til O'zgartirildi! ilovani yopib qayta kiring",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color:  isDark ? AppColors.grenWhite : AppColors.grey,
                            ),
                          ),
                          TextButtonPopular(
                            title: "OK",
                            onPressed: () {
                              context.pop();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
