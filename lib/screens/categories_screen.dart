import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  final String name;
  const CategoriesScreen({super.key, required this.name});

  static const route = "/category/:name";
  static const routeName = "Category";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantsProvider);

    return Scaffold(
      appBar: AppBar(title: Header(heading: name)),
      body: data.when(
        data: (restaurants) {
          restaurants = restaurants
              .where(
                (restaurant) =>
                    restaurant.category == CategoriesHelpers.stringToEnum(name),
              )
              .toList();
          if (restaurants.isEmpty) return const EmptyDisplay();
      appBar: AppBar(
        title: Text(name),
      ),
      body: data.when(
        data: (restaurants) {
          restaurants = restaurants
              .where((restaurant) =>
                  restaurant.category == CategoriesHelpers.stringToEnum(name))
              .toList();
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCard(restaurant: restaurant);
              return RestaurantCard(
                restaurant: restaurant,
              );
            },
          );
        },
        error: (_, __) => const EmptyDisplay(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
