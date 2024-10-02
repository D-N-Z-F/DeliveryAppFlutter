import 'package:flutter/material.dart';

IconData getCategoryIcon(String category) {
  switch (category) {
    case 'japanese':
      return Icons.ramen_dining;
    case 'mexican':
      return Icons.local_pizza;
    case 'korean':
      return Icons.kebab_dining;
    case 'western':
      return Icons.fastfood;
    case 'desserts':
      return Icons.cake;
    case 'vegetarian':
      return Icons.eco;
    case 'vietnamese':
      return Icons.rice_bowl;
    case 'beverages':
      return Icons.local_drink;
    case 'miscellaneous':
      return Icons.restaurant;
    default:
      return Icons.fastfood;
  }
}
