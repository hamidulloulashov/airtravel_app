import 'package:airtravel_app/core/router/routes.dart';
import 'package:airtravel_app/features/auth/pages/onboarding_page.dart';
import 'package:airtravel_app/features/auth/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
  
    ),
     GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingPage(),
  
    ),
  ]
);