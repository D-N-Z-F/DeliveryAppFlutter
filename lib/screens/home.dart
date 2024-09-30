import 'package:delivery_app_flutter/components/widgets/my_sliver_app_bar.dart';
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
      body: const CustomScrollView(
        slivers: [MySliverAppBar()],
      ),
    );
  }
}
