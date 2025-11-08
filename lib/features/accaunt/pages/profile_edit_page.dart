import 'dart:io';
import 'package:airtravel_app/features/accaunt/managers/baseBloc/base_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/baseBloc/base_state.dart';
import 'package:airtravel_app/features/accaunt/managers/userBloc/user_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/userBloc/user_state.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/status.dart';
import '../../../data/model/region_model.dart';
import '../../../data/model/user_model.dart';
import '../../common/widgets/text_button_popular.dart';
import '../../common/widgets/text_field_popular.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  RegionModel? selectedRegion;
  File? photo;

  Future<void> imgSelector() async {
    final picker = ImagePicker();
    final select = await picker.pickImage(source: ImageSource.gallery);
    if (select != null) {
      setState(() {
        photo = File(select.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ma’lumotlar saqlandi')),
          );
          context.go(Routes.profile);
        } else if (state.status == Status.error) {
          Text("xatolik yuz berdi aka");
        }
      },
      child: BlocBuilder<BaseBloc, BaseState>(
        builder: (context, baseState) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == Status.loading ||
                  baseState.status == Status.loading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              final user = state.user;
              final regionList = baseState.regions;

              if (user != null) {
                firstNameController.text = user.firstName;
                lastNameController.text = user.lastName;

                if (selectedRegion == null &&
                    regionList.isNotEmpty &&
                    user.region != null) {
                  selectedRegion = regionList.firstWhere(
                        (r) => r.id == user.region.id,
                    orElse: () => regionList.first,
                  );
                }
              }
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Scaffold(
                appBar: const AppBarWidget(title: "Ma’lumotlarni tahrirlash", showThemeToggle: true,),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 48.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: photo != null
                                ? FileImage(photo!)
                                : (user?.profilePhoto != null ? NetworkImage(user!.profilePhoto!) : null),
                            child: (photo == null && user?.profilePhoto == null)
                                ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: imgSelector,
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Colors.green,
                                child: const Icon(Icons.edit,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      TextFieldPopular(
                        controller: firstNameController,
                        hintText: "Ismingiz",
                      ),
                      SizedBox(height: 16.h),
                      TextFieldPopular(
                        controller: lastNameController,
                        hintText: "Familiyangiz",
                      ),
                      SizedBox(height: 16.h),
                  DropdownButtonFormField<RegionModel>(
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    value: selectedRegion,
                    decoration: InputDecoration(
                      hintText: "Viloyatingiz",
                      hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? AppColors.grey : AppColors.grenWhite,
                    ),
                    items: regionList
                        .map(
                          (r) => DropdownMenuItem(
                        value: r,
                        child: Text(
                          r.title,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (newRegion) {
                      setState(() {
                        selectedRegion = newRegion;
                      });
                    },
                  ),

                  const Spacer(),
                      TextButtonPopular(
                        onPressed: () {
                          if (user == null || selectedRegion == null) return;

                          final updatedUser = UserModel(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            region: selectedRegion!,
                            phoneNumber: user.phoneNumber,
                            isVerified: user.isVerified,
                            balance: user.balance,
                            profilePhoto: user.profilePhoto,
                          );

                          context.read<UserBloc>().add(
                            UpdateUserData(updatedUser, photo: photo),
                          );
                        },
                        title: 'Saqlash',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

