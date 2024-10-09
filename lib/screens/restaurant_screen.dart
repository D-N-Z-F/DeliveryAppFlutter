import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/item_card.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_sliver_app_bar.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key, required this.id});

  static const route = "/restaurant/:id";
  static const routeName = "Restaurant";

  final String id;

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen>
    with SingleTickerProviderStateMixin {
  final restaurantRepo = RestaurantRepo();
  TabController? tabController;

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final restaurant = ref.watch(restaurantProvider(widget.id));
    return Scaffold(
      backgroundColor: scheme.get(MainColors.surface),
      body: restaurant.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text("Restaurant Not Found."));
          }
          final noOfCategories = data.itemCategories.length;
          if (tabController == null ||
              tabController!.length != noOfCategories) {
            tabController = TabController(length: noOfCategories, vsync: this);
          }
          return NestedScrollView(
            headerSliverBuilder: (_, __) => [
              RestaurantSliverAppBar(
                restaurant: data,
                tabController: tabController!,
              )
            ],
            body: TabBarView(
              controller: tabController,
              children: data.itemCategories.map((category) {
                final items = data.items
                    .where((item) => item.category == category)
                    .toList();
                return items.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(Sizes.sm),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) => ItemCard(
                            item: items[index],
                            restaurantId: data.id!,
                            restaurantTitle: data.title,
                          ),
                        ),
                      )
                    : const EmptyDisplay();
              }).toList(),
            ),
          );
        },
        error: (_, __) =>
            const EmptyDisplay(message: Strings.cartDisplayMessage),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
