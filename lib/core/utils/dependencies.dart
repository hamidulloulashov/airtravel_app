import 'package:airtravel_app/data/repositories/aut_repository.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/data/repositories/order_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/orderBloc/order_bloc.dart';
import 'package:airtravel_app/features/common/managers/theme_bloc.dart';
import 'package:airtravel_app/data/repositories/base_repository.dart';
import 'package:airtravel_app/data/repositories/user_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/baseBloc/base_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/userBloc/user_bloc.dart';
import 'package:airtravel_app/features/home/managers/home_bloc.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/features/auth/managers/auth_bloc.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_bloc.dart';
import 'package:airtravel_app/data/repositories/onboarding_repository.dart';

class AppDependencies {
  static final ApiClient client = ApiClient();

  static List<BlocProvider> get providers => [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeLoaded()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepository(client)),
        ),
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(OnboardingRepository(client)),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: UserRepository(client),
          )..add(FetchUserData()),
        ),
        BlocProvider<BaseBloc>(
          create: (context) => BaseBloc(
            baseRepo: BaseRepository(client),
          )..add(BaseFetchRegions()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            repository: HomeRepository(client),
          )..add(const LoadPackages()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(
            orderRepo: OrderRepository(client),
          )..add(OrdersLoading()),
        )
      ];
}
