import 'package:flutter/material.dart';

class Colors {
  Colors._init();

  static const Color primaryDark = Color(0xFF1F2937);
  static const Color primaryLight = Color(0xFF4B5563);
  static const Color accent = Color(0xFF60A5FA);

  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textSecondary = Color(0xFFD1D5DB);
  static const Color background = Color(0xFF111827);
  static const Color cardBackground = Color(0xFF374151);

  static const Color success = Color(0xFF34D399);
  static const Color error = Color(0xFFEF4444);

  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xFFFF9A9E),
        Color(0xFFFAD0C4),
        Color(0xFFFAD0C4),
      ]);
}
