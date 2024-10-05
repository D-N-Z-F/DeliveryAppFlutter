import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider((ref) => RestaurantRepo());

final restaurantsProvider = StreamProvider(
  (ref) => ref.watch(repoProvider).getAllRestaurants(),
);

final restaurantProvider = FutureProvider.family<Restaurant?, String>(
  (ref, restaurantId) =>
      ref.watch(repoProvider).getRestaurantById(restaurantId),
);
