import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/features/accaunt/pages/help_center_page.dart';
import 'package:airtravel_app/features/accaunt/pages/notification_settings_page.dart';
import 'package:airtravel_app/features/accaunt/pages/privacy_policy_page.dart';
import 'package:airtravel_app/features/accaunt/pages/profile_edit_page.dart';
import 'package:airtravel_app/features/accaunt/pages/profile_page.dart';
import 'package:airtravel_app/features/home/pages/home_page.dart';
import 'package:airtravel_app/features/onboarding/pages/onboarding_page.dart';
import 'package:airtravel_app/features/onboarding/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/pages/profile_info_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/verify_code_page.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.signUp,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
  
    // ✅ ProfileInfo - Map yoki String qabul qiladi
    GoRoute(
      path: Routes.profileInfo,
      builder: (context, state) {
        final extra = state.extra;
        
        // ✅ extra ni handle qilamiz
        Map<String, dynamic> params;
        
        if (extra is Map<String, dynamic>) {
          // Map kelsa to'g'ridan-to'g'ri ishlatamiz
          params = extra;
          print('🔍 Router ProfileInfo: Map = $params');
        } else if (extra is String) {
          // String kelsa Map ga o'giramiz
          params = {
            'phoneNumber': extra,
            'isNewUser': true,
          };
          print('🔍 Router ProfileInfo: Telefon = $extra');
        } else {
          // Hech narsa kelmasa default qiymat
          params = {
            'phoneNumber': '',
            'isNewUser': true,
          };
          print('⚠️ Router ProfileInfo: extra yo\'q');
        }
        
        return ProfileInfoPage(extra: params);
      },
    ),
    
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: Routes.profileEdit,
      builder: (context, state) => const ProfileEditPage(),
    ),
    GoRoute(
      path: Routes.privacyPolicy,
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: Routes.notificationSettings,
      builder: (context, state) => const NotificationSettingsPage(),
    ),
    GoRoute(
      path: Routes.helpCenter,
      builder: (context, state) => const HelpCenterPage(),
    ),
    
    // ✅ VerifyCode - String qabul qiladi
    GoRoute(
      path: Routes.verifyCode,
      builder: (context, state) {
        final phoneNumber = state.extra as String? ?? '';
        print('🔍 Router VerifyCode: Telefon = $phoneNumber');
        return VerifyCodePage(phoneNumber: phoneNumber);
      },
    ),
  ],
);