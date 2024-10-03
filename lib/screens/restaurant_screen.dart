import 'package:delivery_app_flutter/common/widgets/food_tile.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_page_sliver_app_bar.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_tab_bar.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key, required this.id});

  static const route = "/restaurant/:id";
  static const routeName = "Restaurant";

  final String id;

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>
    with SingleTickerProviderStateMixin {
  final restaurantRepo = RestaurantRepo();

  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<Restaurant?>(
        future: restaurantRepo
            .getRestaurantById(widget.id), // Fetch restaurant by id
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show a loading indicator
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading restaurant')); // Handle errors
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Text(
                    'Restaurant not found')); // Handle null or missing data
          }

          final restaurant = snapshot.data!;

          if (_tabController == null ||
              _tabController!.length != restaurant.itemCategories.length) {
            _tabController = TabController(
              length: restaurant.itemCategories.length,
              vsync: this,
            );
          }
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    RestaurantPageSliverAppBar(
                        restaurant: restaurant,
                        title: RestaurantTabBar(
                            restaurant: restaurant,
                            tabController: _tabController!)),
                    // Pass the restaurant to the SliverAppBar
                  ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => FoodTile(
                          item: Item(
                              title: "Fish",
                              desc: "2",
                              price: 3,
                              category: restaurant.itemCategories.toString()))),
                ],
              ));
        },
      ),
    );
  }
}
