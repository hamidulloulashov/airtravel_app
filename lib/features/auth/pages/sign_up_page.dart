import 'package:airtravel_app/core/formatter.dart';
import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/features/auth/managers/aut_state.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/auth/managers/auth_event.dart';
import 'package:airtravel_app/features/common/widgets/text_button_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _telefonController = TextEditingController();

  @override
  void dispose() {
    _telefonController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final rawPhone = _telefonController.text.trim();
    final phone = rawPhone.replaceAll(RegExp(r'[^\d+]'), '');

    if (phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Telefon raqam to\'liq kiritilmadi')),
      );
      return;
    }

    context.read<AuthBloc>().add(RegisterUserEvent(phoneNumber: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: Center(
          child: IconButton(
            onPressed: () => context.pop(),
            icon: SvgPicture.asset(AppIcons.arrowLeft),
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          
          if (state is RegistrationSuccess) {
         
            
            if (state.isRegistered) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Xush kelibsiz! Tizimga kirilmoqda...'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ),
              );
              
              Future.delayed(const Duration(milliseconds: 500), () {
                context.go(Routes.home);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.blue,
                ),
              );
              
              context.push(Routes.verifyCode, extra: state.phoneNumber);
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Image.asset(
                    "assets/logo.png",
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    color: AppColors.grenWhite,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Ro'yxatdan o'tish",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  TextFormField(
                    controller: _telefonController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneNumberFormatter],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: "Telefon raqamingizni kiriting",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 70, 68, 68),
                      ),
                      labelText: "Telefon raqami",
                      filled: true,
                      fillColor: AppColors.grenWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Telefon raqami kiritilishi shart';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return TextButtonPopular(
                        title: isLoading ? 'Yuklanmoqda...' : 'Davom etish',
                        onPressed: () => _register(context),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}