import 'package:delivery_app_flutter/state_management/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(lightMode);

  void toggleTheme() {
    state = state == lightMode ? darkMode : lightMode;
  }

  // For ChangeNotifier
  // ThemeData _themeData = lightMode;

  // ThemeData get themeData => _themeData;

  // set themeData(ThemeData themeData) {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  // void toggleTheme() {
  //   if (_themeData == lightMode) {
  //     themeData = darkMode;
  //   } else {
  //     themeData = lightMode;
  //   }
  // }
}

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeData>((ref) => ThemeProvider());
