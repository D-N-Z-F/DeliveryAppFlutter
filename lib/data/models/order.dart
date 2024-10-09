import 'package:delivery_app_flutter/data/models/cart.dart';

class Order {
  final String? id;
  final Cart cart;
  final String dateCreated;
  final double total;

  Order({
    this.id,
    required this.cart,
    required this.dateCreated,
    required this.total,
  });

  Order copy({
    String? id,
    Cart? cart,
    String? dateCreated,
    double? total,
  }) =>
      Order(
        id: id ?? this.id,
        cart: cart ?? this.cart,
        dateCreated: dateCreated ?? this.dateCreated,
        total: total ?? this.total,
      );

  Map<String, dynamic> toMap() => {
        "cart": cart.toMap(),
        "dateCreated": dateCreated,
        "total": total,
      };

  static Order fromMap(Map<String, dynamic> map) => Order(
        cart: Cart.fromMap(map["cart"]),
        dateCreated: map["dateCreated"],
        total: map["total"],
      );

  @override
  String toString() =>
      "Order(ID: $id, Cart: $cart, Date Created: $dateCreated, Total: $total)";
}
