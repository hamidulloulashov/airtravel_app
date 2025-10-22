import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/features/accaunt/widgets/profile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List icons = [
    AppIcons.profile,
    AppIcons.notifications,
    AppIcons.wallet,
    AppIcons.shieldDone,
    AppIcons.moreCircle,
    AppIcons.lock,
    AppIcons.infoSquare,
    AppIcons.send,
    AppIcons.logout,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w, vertical: 200),
            child: Column(
              children: [ProfileItemWidget()],
            ),
          )
        ],
      ),
    );
  }
}
