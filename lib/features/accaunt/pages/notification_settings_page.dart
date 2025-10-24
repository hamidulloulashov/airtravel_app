import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _generalNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Bildirishnoma'),
      body: Column(
        children: [
          _buildNotificationTile(
            title: 'General Notification',
            value: _generalNotificationOn,
            onChanged: (bool value) {
              setState(() {
                _generalNotificationOn = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 24.w, vertical: 10.h),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Switch.adaptive(
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.containerBlack,
            value: value,
            onChanged: onChanged,
            inactiveThumbColor: AppColors.containerBlack,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
