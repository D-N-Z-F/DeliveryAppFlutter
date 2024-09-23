import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String truncateText(String text, int maxLength) =>
      text.length <= maxLength ? text : "${text.substring(0, maxLength)}...";

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static String getFormattedDate(DateTime date,
          {String format = 'dd MM yyyy'}) =>
      DateFormat(format).format(date);

  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();
}
