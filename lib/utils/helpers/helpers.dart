import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';

class Helpers {
  static const listEquality = ListEquality();

  static String truncateText(String text, int maxLength) =>
      text.length <= maxLength ? text : "${text.substring(0, maxLength)}...";

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static String getFormattedDate({
    DateTime? date,
    String format = 'MM/dd/yyyy HH:mm',
  }) =>
      DateFormat(format).format(date ?? DateTime.now());

  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();

  static Future<T?> globalErrorHandler<T>(Future<T> Function() func) async {
    try {
      return await func();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      MyApp.showSnackBar(
        content: e.message ?? Strings.defaultErrorMessage,
        theme: SnackBarTheme.error,
        color: MyColors.error,
      );
    } on StripeException catch (e) {
      debugPrint(e.error.toString());
    } catch (e, _) {
      debugPrint(e.toString());
      MyApp.showSnackBar(
        content: e.toString(),
        theme: SnackBarTheme.error,
        color: MyColors.error,
      );
    }
    return null;
  }
}

extension CategoriesHelpers on Categories {
  String enumToString() => toString().split('.').last.capitalize();

  IconData getIcon() => switch (this) {
        Categories.japanese => Icons.ramen_dining,
        Categories.mexican => Icons.local_pizza,
        Categories.korean => Icons.kebab_dining,
        Categories.western => Icons.fastfood,
        Categories.desserts => Icons.cake,
        Categories.vegetarian => Icons.eco,
        Categories.vietnamese => Icons.rice_bowl,
        Categories.beverages => Icons.local_drink,
        _ => Icons.restaurant
      };

  static Categories stringToEnum(String string) => Categories.values.firstWhere(
        (value) => value.enumToString() == string.capitalize(),
        orElse: () => Categories.miscellaneous,
      );
}

extension StringHelpers on String {
  String capitalize() =>
      isEmpty ? this : this[0].toUpperCase() + substring(1).toLowerCase();
}

extension ColorSchemeHelpers on ColorScheme {
  Color get(MainColors mainColor) => switch (mainColor) {
        MainColors.surface => surface,
        MainColors.inverseSurface => inverseSurface,
        MainColors.primary => primary,
        MainColors.inversePrimary => inversePrimary,
        MainColors.secondary => secondary,
        MainColors.tertiary => tertiary,
        MainColors.tertiaryFixed => tertiaryFixed,
      };
}

extension SnackBarThemeHelpers on SnackBarTheme {
  IconData get() => switch (this) {
        SnackBarTheme.info => Icons.info,
        SnackBarTheme.success => Icons.check,
        SnackBarTheme.warning => Icons.warning,
        SnackBarTheme.error => Icons.error,
      };
}
