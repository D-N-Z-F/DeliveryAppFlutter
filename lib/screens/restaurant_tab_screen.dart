import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantTabScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantTabScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    // Create tabList dynamically from restaurant itemCategories
    final tabList = restaurant.itemCategories.map((category) {
      return SizedBox(
        height: 50.0,
        child: Column(
          children: [Text(category)],
        ),
      );
    }).toList();

    // You might want to define viewList dynamically or keep it static
    // final viewList = List.generate(restaurant.itemCategories.length, (index) {
    //   return Center(
    //     child: Text('View for ${restaurant.itemCategories[index]}'),
    //   );
    // });

    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        bottomNavigationBar: TabBar(tabs: tabList),
      ),
    );
  }
}
