import 'package:flutter/material.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/accaunt/widgets/faq_question_widget.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/aloqa_content_widget.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(title: 'Call Markaz', showThemeToggle: true,),
        body: Column(
          children: [
            buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  FaqQuestionWidget(),
                  AloqaContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  buildTabBar() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Aloqa'),
            ],
            indicatorColor: AppColors.containerBlack,
            labelColor: AppColors.containerGreen,
            unselectedLabelColor:  AppColors.textGrey,
            indicatorWeight: 4.h,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),

            unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.normal),
          ),
          Divider(height: 0, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
