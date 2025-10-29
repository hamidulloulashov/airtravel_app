import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import '../widgets/language_otp_button_widget.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'Uzbek(Uz)';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {'title': "O'zbek", 'subtitle': '(Uz)', 'value': 'Uzbek(Uz)'},
      {'title': 'Ўзбек', 'subtitle': '(Ўз)', 'value': 'Uzbek(Cyr)'},
      {'title': 'Русский', 'subtitle': '(Ру)', 'value': 'Russian(Ru)'},
    ];

    return Scaffold(
      appBar: AppBarWidget(title: 'Language'),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 15.h, bottom: 5.h),
            child: Text(
              'Tavsiya etilgan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
          ),
          ...languages.map((lang) {
            return Column(
              children: [
                LanguageOptionTile(
                  title: lang['title']!,
                  subtitle: lang['subtitle']!,
                  isSelected: _selectedLanguage == lang['value'],
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang['value']!;
                    });
                  },
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
