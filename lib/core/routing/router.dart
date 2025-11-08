import 'package:airtravel_app/core/routing/routes.dart';
import 'package:airtravel_app/features/accaunt/pages/help_center_page.dart';
import 'package:airtravel_app/features/accaunt/pages/language_page.dart';
import 'package:airtravel_app/features/accaunt/pages/notification_settings_page.dart';
import 'package:airtravel_app/features/accaunt/pages/order_history_page.dart';
import 'package:airtravel_app/features/accaunt/pages/payment_history_page.dart';
import 'package:airtravel_app/features/accaunt/pages/privacy_policy_page.dart';
import 'package:airtravel_app/features/accaunt/pages/profile_edit_page.dart';
import 'package:airtravel_app/features/accaunt/pages/profile_page.dart';
import 'package:airtravel_app/features/home/pages/favorit_page.dart';
import 'package:airtravel_app/features/home/pages/home_page.dart';
import 'package:airtravel_app/features/onboarding/pages/onboarding_page.dart';
import 'package:airtravel_app/features/onboarding/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/pages/profile_info_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/verify_code_page.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
      GoRoute(
      path: Routes.like,
      builder: (context, state) => const FavoritesPage(),
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
    GoRoute(
      path: Routes.verifyCode,
      builder: (context, state) {
        final phoneNumber = state.extra as String? ?? '';
        return VerifyCodePage(phoneNumber: phoneNumber);
      },
    ),
    GoRoute(
      path: Routes.profileInfo,
      builder: (context, state) {
        final extra = state.extra;
        Map<String, dynamic> params;

        if (extra is Map<String, dynamic>) {
          params = extra;
        } else if (extra is String) {
          params = {
            'phoneNumber': extra,
            'isNewUser': true,
          };
        } else {
          params = {
            'phoneNumber': '',
            'isNewUser': true,
          };
        }
        return ProfileInfoPage(extra: params);
      },
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: Routes.profileEdit,
      builder: (context, state) => ProfileEditPage(),
    ),
    GoRoute(
      path: Routes.privacyPolicy,
      builder: (context, state) => PrivacyPolicyPage(),
    ),
    GoRoute(
      path: Routes.notificationSettings,
      builder: (context, state) => NotificationSettingsPage(),
    ),
    GoRoute(
      path: Routes.helpCenter,
      builder: (context, state) => HelpCenterPage(),
    ),
    GoRoute(
      path: Routes.language,
      builder: (context, state) => LanguagePage(),
    ),
    GoRoute(
      path: Routes.order,
      builder: (context, state) => OrderHistoryPage(),
    ),
    GoRoute(
      path: Routes.payment,
      builder: (context, state) => PaymentHistoryPage(),
    )
  ],
);
