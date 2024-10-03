import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRecommended extends ConsumerWidget {
  const HomeRecommended({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantsProvider);
    return SliverToBoxAdapter(
      child: restaurants.when(
        data: (data) {
          List<Restaurant> recommended = data;
          recommended.sort((a, b) => b.rating.compareTo(a.rating));
          recommended = recommended.take(5).toList();
          return Column(
            children: [
              const Header(heading: "Recommended"),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommended.length,
                  itemBuilder: (context, index) => RestaurantCard(
                    restaurant: recommended[index],
                    widthRatio: 0.8,
                  ),
                ),
              ),
            ],
          );
        },
        error: (_, __) => const EmptyDisplay(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// SizedBox(
//   height: 250,
//   child: StreamBuilder(
//     stream: restaurantRepo.getAllRestaurants(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) restaurants = snapshot.data!;
//       return SizedBox(
//         width: double.infinity,
//         child: restaurants.isEmpty
//             ? const EmptyDisplay()
//             : ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: restaurants.length,
//                 itemBuilder: (context, index) => RestaurantCard(
//                   restaurant: restaurants[index],
//                   widthRatio: 0.8,
//                 ),
//               ),
//       );
//     },
//   ),
// )