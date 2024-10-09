import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider((ref) => UserRepo());

final favouritesProvider = StreamProvider(
  (ref) => ref.watch(repoProvider).getUserFavourites(),
);

final favouriteProvider = FutureProvider.family<Restaurant?, String>(
  (ref, favouriteId) =>
      ref.watch(repoProvider).getUserFavouriteById(favouriteId),
);
