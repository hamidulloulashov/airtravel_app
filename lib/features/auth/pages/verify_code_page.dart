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

class VerifyCodePage extends StatefulWidget {
  final String phoneNumber;

  const VerifyCodePage({super.key, required this.phoneNumber});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    
    if (widget.phoneNumber.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Telefon raqam topilmadi. Qaytadan urinib ko\'ring.'),
            backgroundColor: Colors.red,
          ),
        );
        context.pop();
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _verifyCode() {
    final code = _code.trim();

    if (code.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("4 xonali kodni to'liq kiriting")),
      );
      return;
    }

    if (widget.phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Telefon raqam topilmadi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
          VerifyCodeEvent(
            phoneNumber: widget.phoneNumber,
            code: code,
          ),
        );
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
        title: Text(
          "Kodni kiriting",
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          
          if (state is VerificationSuccess) {
          
            
            final hasCompleteProfile = state.user != null && 
                                      state.user!.firstName != null && 
                                      state.user!.firstName!.isNotEmpty;
            
            if (state.isExistingUser && hasCompleteProfile) {
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Xush kelibsiz!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go(Routes.home);
            } else {
           
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Iltimos, profilingizni to\'ldiring'),
                  backgroundColor: Colors.blue,
                ),
              );
              context.pushReplacement(
                Routes.profileInfo, 
                extra: {
                  'phoneNumber': widget.phoneNumber,
                  'isNewUser': !state.isExistingUser, 
                },
              );
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
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'SMS kodni kiriting',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color.fromARGB(255, 71, 69, 69),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.phoneNumber.isNotEmpty 
                    ? widget.phoneNumber 
                    : 'Telefon raqam topilmadi',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: widget.phoneNumber.isNotEmpty 
                      ? Colors.black 
                      : Colors.red,
                ),
              ),
              SizedBox(height: 40.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60.w,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.grenWhite,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 100.h),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return TextButtonPopular(
                    title: isLoading ? 'Tekshirilmoqda...' : 'Tasdiqlash',
                    onPressed: isLoading ? () {} : _verifyCode,
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