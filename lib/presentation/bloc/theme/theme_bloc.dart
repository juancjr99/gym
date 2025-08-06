import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
  }

  void _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) {
    final currentState = state;
    ThemeMode newThemeMode;
    
    if (currentState is ThemeInitial) {
      newThemeMode = currentState.themeMode == ThemeMode.dark 
          ? ThemeMode.light 
          : ThemeMode.dark;
    } else if (currentState is ThemeChanged) {
      newThemeMode = currentState.themeMode == ThemeMode.dark 
          ? ThemeMode.light 
          : ThemeMode.dark;
    } else {
      newThemeMode = ThemeMode.dark;
    }
    
    emit(ThemeChanged(themeMode: newThemeMode));
  }

  void _onSetTheme(
    SetTheme event,
    Emitter<ThemeState> emit,
  ) {
    final themeMode = event.isDark ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChanged(themeMode: themeMode));
  }

  ThemeMode get currentThemeMode {
    final currentState = state;
    if (currentState is ThemeInitial) {
      return currentState.themeMode;
    } else if (currentState is ThemeChanged) {
      return currentState.themeMode;
    }
    return ThemeMode.system;
  }
}
