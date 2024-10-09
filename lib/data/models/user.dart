import 'package:delivery_app_flutter/data/models/restaurant.dart';

class User {
  final String? id;
  final String email;
  final String username;
  final List<String> orderHistory;
  final List<Restaurant> favourites;

  User({
    this.id,
    required this.email,
    required this.username,
    this.orderHistory = const [],
    this.favourites = const [],
  });

  User copy({
    String? id,
    String? email,
    String? username,
    List<String>? orderHistory,
    List<Restaurant>? favourites,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        orderHistory: orderHistory ?? this.orderHistory,
        favourites: favourites ?? this.favourites,
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "username": username,
        "orderHistory": orderHistory,
        "favourites": favourites.map((favourite) => favourite.toMap()).toList(),
      };

  static User fromMap(Map<String, dynamic> map) => User(
        email: map["email"],
        username: map["username"],
        orderHistory: List<String>.from(map["orderHistory"]),
        favourites: List<Restaurant>.from(
          map["favourites"].map(
            (restaurantMap) => Restaurant.fromMap(restaurantMap),
          ),
        ),
        favourites: List<String>.from(map["favourites"]),
      );

  @override
  String toString() =>
      "User(ID: $id, Email: $email, Username: $username, Order History: $orderHistory, Favourites: $favourites)";
}
