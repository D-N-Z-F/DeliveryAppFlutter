import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RestaurantTabBar extends StatelessWidget {
  final Restaurant restaurant;
  final TabController tabController;
  const RestaurantTabBar({
    super.key,
    required this.restaurant,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) => TabBar(
        controller: tabController,
        tabs: restaurant.itemCategories
            .map((category) => Header(heading: category, omitMargin: true))
            .toList(),
        isScrollable: true,
        dividerColor: Colors.transparent,
        unselectedLabelColor: MyColors.lightText,
      );

  // You might want to define viewList dynamically or keep it static
  // final viewList = List.generate(restaurant.itemCategories.length, (index) {
  //   return Center(
  //     child: Text('View for ${restaurant.itemCategories[index]}'),
  //   );
  // });
}
