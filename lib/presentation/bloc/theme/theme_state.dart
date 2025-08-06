import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
