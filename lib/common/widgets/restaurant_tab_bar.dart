import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantTabBar extends StatelessWidget {
  final Restaurant restaurant;
  final TabController tabController;
  const RestaurantTabBar(
      {super.key, required this.restaurant, required this.tabController});

  @override
  Widget build(BuildContext context) {
    // Create tabList dynamically from restaurant itemCategories
    final tabList = restaurant.itemCategories.map((category) {
      return Text(category, style: const TextStyle(color: Colors.white, fontSize: 18),);
    }).toList();

    return TabBar(
      controller: tabController,
      tabs: tabList,
      isScrollable: true,
      dividerColor: Colors.transparent,
    );

    // You might want to define viewList dynamically or keep it static
    // final viewList = List.generate(restaurant.itemCategories.length, (index) {
    //   return Center(
    //     child: Text('View for ${restaurant.itemCategories[index]}'),
    //   );
    // });
  }
}
