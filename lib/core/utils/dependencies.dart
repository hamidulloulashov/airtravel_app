import 'package:airtravel_app/data/repositories/aut_repository.dart';
import 'package:airtravel_app/data/repositories/base_repository.dart';
import 'package:airtravel_app/data/repositories/user_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/baseBloc/base_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/userBloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_bloc.dart';
import 'package:airtravel_app/data/repositories/onboarding_repository.dart';

class AppDependencies {
  static final ApiClient _client = ApiClient();

  static List<BlocProvider> providers = [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthRepository(_client)),
    ),
    BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(OnboardingRepository(_client)),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        userRepository: UserRepository(_client),
      )..add(FetchUserData()),
    ),
    BlocProvider<BaseBloc>(
      create: (context) => BaseBloc(
        baseRepo: BaseRepository(_client)
      )..add(BaseFetchRegions()),
    )
  ];
}
