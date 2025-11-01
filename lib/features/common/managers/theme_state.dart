part of 'theme_bloc.dart';

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.light});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}