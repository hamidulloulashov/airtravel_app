import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItemWidget extends StatelessWidget {
  final String? text;
  final String? icon;
  final String? iconBack;

  const ProfileItemWidget({
    super.key,
    this.text,
    this.icon,
    this.iconBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 0.5,
          children: [
            SvgPicture.asset(icon ?? ""),
            Text(text ?? ""),
          ],
        ),
        SvgPicture.asset(iconBack ?? ""),
      ],
    );
  }
}
