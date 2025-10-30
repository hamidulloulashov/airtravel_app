import 'dart:io';
import 'package:airtravel_app/core/routing/routes.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/features/auth/managers/aut_state.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/auth/managers/auth_event.dart';
import 'package:airtravel_app/features/common/widgets/text_button_popular.dart';
import 'package:airtravel_app/features/common/widgets/text_field_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInfoPage extends StatefulWidget {
  final Map<String, dynamic> extra; 

  const ProfileInfoPage({super.key, required this.extra});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final ismController = TextEditingController();
  final familiyaController = TextEditingController();
  String? tanlanganViloyat;
  File? rasm;

  String get phoneNumber {
    try {
      final value = widget.extra['phoneNumber'] ?? 
                    widget.extra['phone_number'] ?? 
                    '';
      return value is String ? value : '';
    } catch (e) {
      print('❌ phoneNumber olishda xato: $e');
      return '';
    }
  }
  
  bool get isNewUser {
    try {
      final value = widget.extra['isNewUser'] ?? true;
      return value is bool ? value : true;
    } catch (e) {
      print('❌ isNewUser olishda xato: $e');
      return true;
    }
  }

  final viloyatlar = {
    'Toshkent': 1,
    'Samarqand': 2,
    'Farg\'ona': 3,
    'Buxoro': 4,
    'Namangan': 5,
    'Xorazm': 6,
    'Qashqadaryo': 7,
    'Surxondaryo': 8,
    'Andijon': 9,
    'Jizzax': 10,
    'Navoiy': 11,
    'Sirdaryo': 12,
    'Qoraqalpog\'iston': 13,
  };

  @override
  void initState() {
    super.initState();
    print('📱 ProfileInfoPage: extra = ${widget.extra}');
    print('📱 ProfileInfoPage: Telefon raqam = $phoneNumber');
    print('🔍 isNewUser = $isNewUser');
  }

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
  void dispose() {
    ismController.dispose();
    familiyaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 75,
        leading: Center(
          child: IconButton(
            onPressed: () => context.pop(),
            icon: SvgPicture.asset(AppIcons.arrowLeft),
          ),
        ),
        title: Text(
          "Ma'lumotlarni kiriting",
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profil saqlandi!')),
            );
            context.go(Routes.home); 
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
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
                    child: rasm == null
                        ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                        : null,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.grenWhite,
                ),
                items: viloyatlar.keys
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (yangi) => setState(() => tanlanganViloyat = yangi),
              ),
              Spacer(),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return TextButtonPopular(
                    onPressed: () {
                      if (isLoading) return;

                      if (ismController.text.isEmpty ||
                          familiyaController.text.isEmpty ||
                          tanlanganViloyat == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Barcha maydonlarni to\'ldiring'),
                          ),
                        );
                        return;
                      }

                      if (phoneNumber.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Telefon raqam topilmadi. Qaytadan kiriting.'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      final regionId = viloyatlar[tanlanganViloyat];

                      context.read<AuthBloc>().add(
                            UpdateProfileEvent(
                              firstName: ismController.text.trim(),
                              lastName: familiyaController.text.trim(),
                              region: regionId.toString(),
                              profileImage: rasm,
                              phoneNumber: phoneNumber, 
                              isNewUser: isNewUser,
                            ),
                          );
                    },
                    title: isLoading ? 'Saqlanmoqda...' : 'Saqlash',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}