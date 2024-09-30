import 'package:flutter/material.dart';

class MyColors {
  MyColors._init();

  static const Color lightSurface = Color(0xFFE5E7EB);
  static const Color darkSurface = Color(0xFF111827);
  static const Color primary = Color(0xFF60A5FA);

  static const Color lightAccent = Color(0xFF4B5563);
  static const Color darkAccent = Color(0xFF1F2937);

  static const Color lightText = Color(0xFFF9FAFB);
  static const Color darkText = Color(0xFFD1D5DB);

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
