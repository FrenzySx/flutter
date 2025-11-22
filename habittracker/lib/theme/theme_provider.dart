import 'package:flutter/material.dart';
import 'package:habittracker/theme/dark_mode.dart';
import 'package:habittracker/theme/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider({bool isDark = true, this.onChanged})
    : _themeData = isDark ? darkMode : lightMode;

  final void Function(bool isDark)? onChanged;
  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
    onChanged?.call(isDarkMode);
  }
}
