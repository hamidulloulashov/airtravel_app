import 'dart:io';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/features/accaunt/widgets/profile_item_widget.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? rasm;

  Future<void> _rasmTanlash() async {
    final picker = ImagePicker();
    final tanlangan = await picker.pickImage(source: ImageSource.gallery);
    if (tanlangan != null) {
      setState(() {
        rasm = File(tanlangan.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 10.h
            ),
            child: Column(
              spacing: 20.h,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 42.w,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(AppIcons.more)
                  ],
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: rasm != null ? FileImage(rasm!) : null,
                      backgroundColor: Colors.grey.shade200,
                      child: rasm == null ? Icon(Icons.person, size: 60.sp, color: Colors.grey) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _rasmTanlash,
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.cardGrey,
                ),
                Column(
                  spacing: 10.h,
                  children: [
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Profilni taxrirlash',
                      icon: AppIcons.profile,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Bildirishnoma',
                      icon: AppIcons.notifications,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'To’lovlar',
                      icon: AppIcons.wallet,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Buyurtma tarixi',
                      icon: AppIcons.shieldDone,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Ilova tili',
                      icon: AppIcons.moreCircle,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Maxfiylik Siyosati',
                      icon: AppIcons.lock,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Call Markaz',
                      icon: AppIcons.infoSquare,
                      iconBack: AppIcons.arrowRightGreen,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      text: 'Ulashish ',
                      icon: AppIcons.send,
                    ),
                    ProfileItemWidget(
                      onTap: () {},
                      textColor: AppColors.error,
                      iconColorFilter: ColorFilter.mode(
                        AppColors.error,
                        BlendMode.srcIn,
                      ),
                      text: 'Chiqish',
                      icon: AppIcons.logout,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
