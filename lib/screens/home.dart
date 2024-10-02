import 'package:delivery_app_flutter/common/widgets/home_sliver_app_bar.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/utils/constants/icons.dart';
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
    List<String> categories = [
      'japanese',
      'mexican',
      'korean',
      'western',
      'desserts',
      'vegetarian',
      'vietnamese',
      'beverages',
      'miscellaneous',
    ];

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
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 16, // Adjust font size here
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                SizedBox(
                  height:
                      150, // Adjust the height for the category button container
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      itemCount: 9,
                      itemBuilder: (_, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      getCategoryIcon(
                                          category), // Get the corresponding icon
                                      color: Colors.white,
                                      size: 40, // Adjust icon size
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                category,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        );
                      }),
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
                    "Recommended",
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
                  style:
                      TextStyle(fontSize: Sizes.font["md"], letterSpacing: 2.0),
                ),
              ),
            ],
          )),
          StreamBuilder(
            stream: restaurantRepo.getAllRestaurants(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                restaurants = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Ensure you only handle valid indexes based on the restaurants list size
                      if (index < restaurants.length) {
                        return SizedBox(
                          height: 250,
                          child: RestaurantCard(
                            restaurant: restaurants[index],
                          ),
                        );
                      } else {
                        return const EmptyDisplay(); // Fallback if no restaurants are found
                      }
                    },
                    childCount: restaurants.isEmpty
                        ? 1
                        : restaurants.length, // Prevents empty rendering
                  ),
                );
              } else if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error loading restaurants'),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child:
                        CircularProgressIndicator(), // Loading indicator while waiting for data
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
