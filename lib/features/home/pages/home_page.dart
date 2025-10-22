import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Meni yoz!!!", style: TextStyle(color: Colors.white, fontSize: 40),))
        ],
      )
    );
  }
}