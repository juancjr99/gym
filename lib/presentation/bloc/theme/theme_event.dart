import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

class SetTheme extends ThemeEvent {
  const SetTheme(this.isDark);

  final bool isDark;

  @override
  List<Object> get props => [isDark];
}
