import 'package:delivery_app_flutter/data/models/item.dart';

class Cart {
  final String userId;
  final String restaurantId;
  final List<Item> items;

  Cart({
    required this.userId,
    required this.restaurantId,
    this.items = const [],
  });

  Cart copy(String? userId, String? restaurantId, List<Item>? items) => Cart(
        userId: userId ?? this.userId,
        restaurantId: restaurantId ?? this.restaurantId,
        items: items ?? this.items,
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "restaurantId": restaurantId,
        "items": items.map((item) => item.toMap()).toList(),
      };

  static Cart fromMap(Map<String, dynamic> map) => Cart(
        userId: map["userId"],
        restaurantId: map["restaurantId"],
        items: map["items"] != null
            ? List<Item>.from(
                map["items"].map((itemMap) => Item.fromMap(itemMap)),
              )
            : [],
      );

  @override
  String toString() =>
      "Cart(UserID: $userId, RestaurantID: $restaurantId)\nItems: $items";
}
