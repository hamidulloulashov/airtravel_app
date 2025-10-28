import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBlue,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.canPop(context);
          },
        ),
        backgroundColor: AppColors.containerBlue, 
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Meni yoz!!!",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
