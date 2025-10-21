import 'package:airtravel_app/core/router/router.dart' as AppRouter;
import 'package:airtravel_app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
void main(List<String> args) {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'My Cooking App',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          routerConfig: AppRouter.router,
        );
  }
}