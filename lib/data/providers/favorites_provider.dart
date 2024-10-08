import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider =
    StateProvider.family<bool, String>((ref, restaurantId) => false);
