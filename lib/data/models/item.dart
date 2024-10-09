class Item {
  final String? id;
  final String title;
  final String desc;
  final double price;
  final String category;
  final String imageUrl;

  Item({
    this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  Item copy({
    String? id,
    String? title,
    String? desc,
    double? price,
    String? category,
    String? imageUrl,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        price: price ?? this.price,
        category: category ?? this.category,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "desc": desc,
        "price": price,
        "category": category,
        "imageUrl": imageUrl,
      };

  static Item fromMap(Map<String, dynamic> map) => Item(
        title: map["title"],
        desc: map["desc"],
        price: map["price"],
        category: map["category"],
        imageUrl: map["imageUrl"],
      );

  @override
  String toString() =>
      "Item(ID: $id, Title: $title, Desc: $desc, Price: $price, Category: $category, Image URL: $imageUrl)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.price == price &&
        other.category == category &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      desc.hashCode ^
      price.hashCode ^
      category.hashCode ^
      imageUrl.hashCode;
}
