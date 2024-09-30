class User {
  final String? id;
  final String email;
  final String username;
  final List<String> orderHistory;
  final List<String> favourites;

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
    List<String>? favourites,
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
        "favourites": favourites
      };

  static User fromMap(Map<String, dynamic> map) => User(
        email: map["email"],
        username: map["username"],
        orderHistory: map["orderHistory"],
        favourites: map["favourites"],
      );

  @override
  String toString() =>
      "User(ID: $id, Email: $email, Username: $username)\nOrder History: $orderHistory";
}
