class User {
  final String? id;
  final String email;
  final String username;
  final List<String> orderHistory;

  User(
      {this.id,
      required this.email,
      required this.username,
      this.orderHistory = const []});

  User copy(String? id, String? email, String? username,
          List<String>? orderHistory) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        orderHistory: orderHistory ?? this.orderHistory,
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "username": username,
        "orderHistory": orderHistory,
      };

  static User fromMap(Map<String, dynamic> map) => User(
        email: map["email"],
        username: map["username"],
        orderHistory: map["orderHistory"],
      );

  @override
  String toString() =>
      "User(ID: $id, Email: $email, Username: $username)\nOrder History: $orderHistory";
}
