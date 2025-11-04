import 'package:airtravel_app/core/utils/dependencies.dart';
import 'package:airtravel_app/features/common/managers/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:airtravel_app/core/routing/router.dart' as AppRouter;
import 'package:airtravel_app/core/utils/app_theme.dart';

import 'core/client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClient.initLanguage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppDependencies.providers,
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Air Travel App',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: state.themeMode, 
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}