class Item {
  final String? id;
  final String title;
  final String desc;
  final double price;
  final String category;

  Item({
    this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.category,
  });

  Item copy({
    String? id,
    String? title,
    String? desc,
    double? price,
    String? category,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        price: price ?? this.price,
        category: category ?? this.category,
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "desc": desc,
        "price": price,
        "category": category,
      };

  static Item fromMap(Map<String, dynamic> map) => Item(
        title: map["title"],
        desc: map["desc"],
        price: map["price"],
        category: map["category"],
      );

  @override
  String toString() =>
      "Item(ID: $id, Title: $title, Desc: $desc, Price: $price, Category: $category)";
}
