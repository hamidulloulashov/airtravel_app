import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/features/auth/managers/aut_state.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/auth/managers/auth_event.dart';
import 'package:airtravel_app/features/auth/widgets/logo_widget.dart';
import 'package:airtravel_app/features/auth/widgets/page_title_widget.dart';
import 'package:airtravel_app/features/auth/widgets/phone_text_widget.dart';
import 'package:airtravel_app/features/auth/widgets/phone_validatsiya_widget.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/common/widgets/text_button_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _telefonController = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _telefonController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    setState(() {
      _hasError = !(_formKey.currentState?.validate() ?? false);
    });

    if (_hasError) return;

    final rawPhone = _telefonController.text.trim();
    final phone = PhoneValidatsiyaWidget.formatPhone(rawPhone);

    if (!PhoneValidatsiyaWidget.isValidUzbekPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Noto\'g\'ri telefon raqam'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(RegisterUserEvent(phoneNumber: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        showThemeToggle: true,
        leadingIcon: Icon(Icons.arrow_back),
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
                  const LogoWidget(),
                  SizedBox(height: 40.h),
                  const PageTitleWidget(title: "Ro'yxatdan o'tish"),
                  SizedBox(height: 40.h),
                  PhoneTextWidget(
                    controller: _telefonController,
                    hasError: _hasError,
                    validator: PhoneValidatsiyaWidget.validate,
                    onChanged: (value) {
                      if (_hasError) {
                        setState(() {
                          _hasError = false;
                        });
                        _formKey.currentState?.validate();
                      }
                    },
                  ),
                  SizedBox(height: 32.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return TextButtonPopular(
                        title: isLoading ? 'Yuklanmoqda...' : 'Davom etish',
                        onPressed: isLoading ? () {} : () => _register(context),
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