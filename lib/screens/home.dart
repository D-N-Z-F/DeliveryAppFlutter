import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = "/";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = UserRepo();
    final restaurantRepo = RestaurantRepo();
    List<Restaurant> restaurants = [];
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: StreamBuilder(
        stream: restaurantRepo.getAllRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) restaurants = snapshot.data!;
          return restaurants.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info,
                        color: Colors.grey,
                        size: 50.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Text("No data to show."),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) =>
                      RestaurantCard(restaurant: restaurants[index]),
                );
        },
      ),
    );
  }
}
