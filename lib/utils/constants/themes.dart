import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// final ThemeData lightTheme = ThemeData(
//   textTheme: GoogleFonts.poppinsTextTheme(),
//   brightness: Brightness.light,
//   scaffoldBackgroundColor: Colors.white,
//   colorScheme: ColorScheme.light(
//     surface: Colors.grey.shade300,
//     primary: Colors.grey.shade500,
//     secondary: Colors.grey.shade100,
//     tertiary: Colors.white,
//     inversePrimary: Colors.grey.shade700,
//   ),
//   useMaterial3: true,
// );

// final ThemeData darkTheme = ThemeData(
//   textTheme: GoogleFonts.poppinsTextTheme(),
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: Colors.black,
//   colorScheme: ColorScheme.dark(
//     surface: const Color.fromARGB(255, 20, 20, 20),
//     primary: const Color.fromARGB(255, 122, 122, 122),
//     secondary: const Color.fromARGB(255, 30, 30, 30),
//     tertiary: const Color.fromARGB(255, 47, 47, 47),
//     inversePrimary: Colors.grey.shade300,
//   ),
//   useMaterial3: true,
// );

final ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: MyColors.darkAccent,
    displayColor: MyColors.darkAccent,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColors.lightSurface,
  colorScheme: const ColorScheme.light(
    surface: MyColors.lightSurface,
    inverseSurface: MyColors.darkSurface,
    primary: MyColors.lightPrimary,
    inversePrimary: MyColors.darkPrimary,
    secondary: MyColors.lightAccent,
    tertiary: MyColors.darkAccent,
    tertiaryFixed: MyColors.lightSurface,
  ),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: MyColors.lightAccent,
    displayColor: MyColors.lightAccent,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.darkSurface,
  colorScheme: const ColorScheme.dark(
    surface: MyColors.darkSurface,
    inverseSurface: MyColors.lightSurface,
    primary: MyColors.darkPrimary,
    inversePrimary: MyColors.lightPrimary,
    secondary: MyColors.darkAccent,
    tertiary: MyColors.lightAccent,
    tertiaryFixed: MyColors.lightSurface,
  ),
  useMaterial3: true,
);
