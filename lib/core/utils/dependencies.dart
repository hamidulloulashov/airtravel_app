import 'package:airtravel_app/data/repositories/aut_repository.dart';
import 'package:airtravel_app/features/common/managers/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_bloc.dart';
import 'package:airtravel_app/data/repositories/onboarding_repository.dart';

class AppDependencies {
  static final ApiClient _client = ApiClient();

  static List<BlocProvider> get providers => [
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc()..add(ThemeLoaded()),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthRepository(_client)),
    ),
    BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(OnboardingRepository(_client)), 
    ),
  ];
}