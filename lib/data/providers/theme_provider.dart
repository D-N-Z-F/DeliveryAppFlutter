import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/utils/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(lightTheme) {
    checkForSavedTheme();
  }

  final hive = HiveService();

  void checkForSavedTheme() async {
    final theme = await hive.getAppThemeFromBox();
    state = theme == "darkTheme" ? darkTheme : lightTheme;
  }

  void toggleTheme() {
    final newTheme = state == lightTheme ? darkTheme : lightTheme;
    updatePreference(newTheme);
    state = newTheme;
  }

  void updatePreference(ThemeData newTheme) async =>
      await hive.updateAppThemeInBox(
        newTheme == darkTheme ? "darkTheme" : "lightTheme",
      );
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>(
  (ref) => ThemeProvider(),
);
