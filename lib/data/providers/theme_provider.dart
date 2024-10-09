import 'package:delivery_app_flutter/utils/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(lightTheme);

  void toggleTheme() => state = state == lightTheme ? darkTheme : lightTheme;
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>(
  (ref) => ThemeProvider(),
);
