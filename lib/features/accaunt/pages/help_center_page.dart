
import 'package:flutter/material.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
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
                  Center(child: Text('FAQ (Tez-tez beriladigan savollar) kontenti shu yerda bo\'ladi')),
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
          labelColor: AppColors.containerBlack, // Aktiv tab yozuvi rangi
          unselectedLabelColor: Colors.grey, // Noaktiv tab yozuvi rangi
          indicatorWeight: 2.0, // Indikator chizig'i qalinligi
          indicatorSize: TabBarIndicatorSize.tab, // Indikatorni tab kengligida qilish
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        ),
        const Divider(height: 0, thickness: 1, color: Colors.grey),
      ],
    );
  }
}



