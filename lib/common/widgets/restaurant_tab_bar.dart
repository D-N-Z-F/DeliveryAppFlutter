import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
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
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TabBar(
      controller: tabController,
      tabs: restaurant.itemCategories
          .map((category) => Header(
                heading: category,
                omitMargin: true,
                color: scheme.get(MainColors.inversePrimary),
              ))
          .toList(),
      isScrollable: true,
      dividerColor: Colors.transparent,
    );
  }
}
