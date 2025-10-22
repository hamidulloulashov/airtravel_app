import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          ...List.generate(icons.length, (index) {
            return SvgPicture.asset(
              icons[index],
              height: 32,
              width: 32,
            );
          })
        ],
      ),
    );
  }
}
