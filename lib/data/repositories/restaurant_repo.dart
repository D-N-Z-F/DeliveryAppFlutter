import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';

class RestaurantRepo {
  static final RestaurantRepo _instance = RestaurantRepo._init();
  factory RestaurantRepo() => _instance;
  RestaurantRepo._init();

  final _collection = FirebaseFirestore.instance.collection("restaurants");

  Stream<List<Restaurant>> getAllRestaurants(
          {String? query, bool isSearch = false}) =>
      _collection.snapshots().map((event) => event.docs
          .map((doc) => Restaurant.fromMap(doc.data()).copy(id: doc.id))
          .where((restaurant) =>
              !isSearch ||
              (query != null &&
                  query.isNotEmpty &&
                  restaurant.title.toLowerCase().contains(
                        query.toLowerCase(),
                      )))
          .toList());

  Future<Restaurant?> getRestaurantById(String id) async {
    final restaurant = await Helpers.globalErrorHandler(() async {
      final snapshot = await _collection.doc(id).get();
      return snapshot.exists ? Restaurant.fromMap(snapshot.data()!) : null;
    });
    return restaurant;
  }

  Future<void> createRestaurant(Restaurant restaurant) async {
    await Helpers.globalErrorHandler(() => _collection.add(restaurant.toMap()));
  }

  Future<void> updateRestaurant(String id, Restaurant restaurant) async {
    await Helpers.globalErrorHandler(
      () => _collection.doc(id).set(restaurant.toMap()),
    );
  }

  Future<void> deleteRestaurant(String id) async {
    await Helpers.globalErrorHandler(() => _collection.doc(id).delete());
  }
}
