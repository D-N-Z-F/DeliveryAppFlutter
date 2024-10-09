import 'package:delivery_app_flutter/utils/constants/enums.dart';

class User {
  final String? id;
  final String email;
  final String username;
  final List<String> orderHistory;
  final Status status;

  User(
      {this.id,
      required this.email,
      required this.username,
      required this.orderHistory,
      this.status = Status.normal});

  User copy(String? id, String? email, String? username,
          List<String>? orderHistory, Status? status) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        orderHistory: orderHistory ?? this.orderHistory,
        status: status ?? this.status,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "orderHistory": orderHistory,
        "status": status
      };

  static User fromMap(Map<String, dynamic> map) => User(
        id: map["id"],
        email: map["email"],
        username: map["username"],
        orderHistory: map["orderHistory"],
        status: map["status"],
      );

  @override
  String toString() =>
      "User(ID: $id, Email: $email, Username: $username, Status: $status)\nOrder History: $orderHistory";
}
