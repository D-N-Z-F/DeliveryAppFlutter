import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';

class Restaurant {
  final String? id;
  final String title;
  final String desc;
  final List<Item> items;
  final double rating;
  final Categories category;
  final List<String> itemCategories;
  final String imageUrl;

  Restaurant({
    this.id,
    required this.title,
    required this.desc,
    this.items = const [],
    required this.rating,
    required this.category,
    required this.itemCategories,
    this.imageUrl = "",
  });

  Restaurant copy({
    String? id,
    String? title,
    String? desc,
    List<Item>? items,
    double? rating,
    Categories? category,
    List<String>? itemCategories,
    String? imageUrl,
  }) =>
      Restaurant(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        items: items ?? this.items,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        itemCategories: itemCategories ?? this.itemCategories,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "desc": desc,
        "items": items.map((item) => item.toMap()).toList(),
        "rating": rating,
        "category": category.enumToString(),
        "itemCategories": itemCategories,
        "imageUrl": imageUrl
      };

  static Restaurant fromMap(Map<String, dynamic> map) => Restaurant(
        id: map["id"],
        title: map["title"],
        desc: map["desc"],
        items: List<Item>.from(
          map["items"].map((itemMap) => Item.fromMap(itemMap)),
        ),
        rating: map["rating"],
        category: CategoriesHelpers.stringToEnum(map["category"]),
        itemCategories: List<String>.from(map["itemCategories"]),
        imageUrl: map["imageUrl"],
      );

  @override
  String toString() =>
      "Restaurant(ID: $id, Title: $title, Desc: $desc, Rating: $rating, Item Categories: $itemCategories)\nItems: $items";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Restaurant &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        Helpers.listEquality.equals(other.items, items) &&
        Helpers.listEquality.equals(other.itemCategories, itemCategories) &&
        other.rating == rating &&
        other.category == category &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      rating.hashCode ^
      category.hashCode ^
      Helpers.listEquality.hash(items) ^
      Helpers.listEquality.hash(itemCategories) ^
      imageUrl.hashCode;
}
