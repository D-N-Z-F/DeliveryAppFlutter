import 'package:delivery_app_flutter/common/widgets/home_sliver_app_bar.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = "/home";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantRepo = RestaurantRepo();
    List<Restaurant> restaurants = [];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                        fontSize: Sizes.font["md"], letterSpacing: 2.0),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: StreamBuilder(
                    stream: restaurantRepo.getAllRestaurants(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) restaurants = snapshot.data!;
                      return SizedBox(
                        width: double.infinity,
                        child: restaurants.isEmpty
                            ? const EmptyDisplay()
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurants.length,
                                itemBuilder: (context, index) => RestaurantCard(
                                    restaurant: restaurants[index]),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                        fontSize: Sizes.font["md"], letterSpacing: 2.0),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: StreamBuilder(
                    stream: restaurantRepo.getAllRestaurants(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) restaurants = snapshot.data!;
                      return SizedBox(
                        width: double.infinity,
                        child: restaurants.isEmpty
                            ? const EmptyDisplay()
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurants.length,
                                itemBuilder: (context, index) => RestaurantCard(
                                    restaurant: restaurants[index]),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                        fontSize: Sizes.font["md"], letterSpacing: 2.0),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: StreamBuilder(
                    stream: restaurantRepo.getAllRestaurants(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) restaurants = snapshot.data!;
                      return SizedBox(
                        width: double.infinity,
                        child: restaurants.isEmpty
                            ? const EmptyDisplay()
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurants.length,
                                itemBuilder: (context, index) => RestaurantCard(
                                    restaurant: restaurants[index]),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
