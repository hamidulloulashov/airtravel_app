import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/features/accaunt/pages/profile_page.dart';
import 'package:airtravel_app/features/home/pages/home_page.dart';
import 'package:airtravel_app/features/onboarding/pages/onboarding_page.dart';
import 'package:airtravel_app/features/onboarding/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/pages/profile_info_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/verify_code_page.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.profilePage,
  routes: [
    GoRoute(
      path: Routes.splash,
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
      builder: (context, state) => const VerifyCodePage(),
    ),
    GoRoute(
      path: Routes.profileInfo,
      builder: (context, state) => const ProfileInfoPage(),
    ),
    GoRoute(
      path: Routes.profilePage,
      builder: (context, state) => const ProfilePage(),
    )
  ],
);
