import 'package:airtravel_app/features/accaunt/widgets/build_notification_tile.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBarWidget(title: 'Bildirishnoma', showThemeToggle: true,),
      body: Column(
        children: [
          BuildNotificationTile(
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

}