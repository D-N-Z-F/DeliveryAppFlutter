import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String truncateText(String text, int maxLength) =>
      text.length <= maxLength ? text : "${text.substring(0, maxLength)}...";

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static String getFormattedDate(DateTime? date,
      {String format = 'dd MM yyyy'}) {
    date ??= DateTime.now();
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();

  static Future<T?> globalErrorHandler<T>(Future<T> Function() func) async {
    try {
      return await func();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }
    return null;
  }
}

extension CategoriesHelpers on Categories {
  String enumToString() => toString().split('.').last;

  static Categories stringToEnum(String string) => Categories.values.firstWhere(
        (value) => value.enumToString() == string,
        orElse: () => Categories.miscellaneous,
      );
}
