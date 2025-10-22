import 'dart:io';

import 'package:airtravel_app/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_icons.dart';
import '../../common/widgets/text_button_popular.dart';
import '../../common/widgets/text_field_popular.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final ismController = TextEditingController();
  final familiyaController = TextEditingController();
  String? tanlanganViloyat;
  File? rasm;

  final viloyatlar = [
    'Toshkent',
    'Samarqand',
    'Farg‘ona',
    'Buxoro',
    'Namangan',
    'Xorazm',
    'Qashqadaryo',
    'Surxondaryo',
  ];

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 75,
        leading: Center(
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(AppIcons.arrowLeft),
          ),
        ),
        title: Text(
          "Ma'lumotlarni kiriting",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24.h,
          children: [
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
            TextFieldPopular(
              controller: ismController,
              hintText: "Ismingiz",
            ),
            TextFieldPopular(
              controller: familiyaController,
              hintText: "Familyangiz",
            ),
            DropdownButtonFormField<String>(
              value: tanlanganViloyat,
              decoration: InputDecoration(
                hintText: "Viloyatingiz",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColors.grenWhite,
              ),
              items: viloyatlar
                  .map(
                    (v) => DropdownMenuItem(
                      value: v,
                      child: Text(v),
                    ),
                  )
                  .toList(),
              onChanged: (yangi) => setState(() {
                tanlanganViloyat = yangi;
              }),
            ),
            Spacer(),
            TextButtonPopular(
              onPressed: () {
                context.go(Routes.profilePage);
              },
              title: 'Saqlash',
            ),
          ],
        ),
      ),
    );
  }
}
