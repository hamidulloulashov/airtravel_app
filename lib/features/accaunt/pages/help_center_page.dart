import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/accaunt/widgets/faq_question_widget.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/aloqa_content_widget.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(title: 'Call Markaz'),
        body: Column(
          children: [
            _buildTabBar(),
            const Expanded(
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

  Widget _buildTabBar() {
    return Column(
      children: [
        TabBar(
          tabs: const [
            Tab(text: 'FAQ'),
            Tab(text: 'Aloqa'),
          ],
          indicatorColor: AppColors.containerBlack,
          labelColor: AppColors.containerGreen, // Aktiv tab yozuvi rangi
          unselectedLabelColor: AppColors.textGrey, // Noaktiv tab yozuvi rangi
          indicatorWeight: 4.h, // Indikator chizig'i qalinligi
          indicatorSize:
              TabBarIndicatorSize.tab, // Indikatorni tab kengligida qilish
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        ),
        const Divider(height: 0, thickness: 1, color: Colors.grey),
      ],
    );
  }
}
