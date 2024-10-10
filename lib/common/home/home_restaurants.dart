import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRestaurants extends ConsumerWidget {
  const HomeRestaurants({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantsProvider);
    return restaurants.when(
      data: (data) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => SizedBox(
            height: 250,
            child: RestaurantCard(restaurant: data[index]),
          ),
          childCount: data.length,
        ),
      ),
      error: (_, __) => const SliverToBoxAdapter(child: EmptyDisplay()),
      loading: () => const SliverToBoxAdapter(
        child: Center(child: LoadingIndicator()),
      ),
    );
  }
}
