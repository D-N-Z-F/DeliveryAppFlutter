import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';

class Restaurant {
  final String? id;
  final String title;
  final String desc;
  final List<Item> items;
  final int rating;
  final Categories category;
  final List<String> itemCategories;

  Restaurant({
    this.id,
    required this.title,
    required this.desc,
    this.items = const [],
    required this.rating,
    required this.category,
    required this.itemCategories,
  });

  Restaurant copy(
    String? id,
    String? title,
    String? desc,
    List<Item>? items,
    int? rating,
    Categories? category,
    List<String>? itemCategories,
  ) =>
      Restaurant(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        items: items ?? this.items,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        itemCategories: itemCategories ?? this.itemCategories,
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "desc": desc,
        "items": items.map((item) => item.toMap()).toList(),
        "rating": rating,
        "category": category.enumToString(),
        "itemCategories": itemCategories,
      };

  static Restaurant fromMap(Map<String, dynamic> map) => Restaurant(
        title: map["title"],
        desc: map["desc"],
        items: map["items"],
        rating: map["rating"],
        category: CategoriesHelpers.stringToEnum(map["category"]),
        itemCategories: map["itemCategories"],
      );

  @override
  String toString() =>
      "Restaurant(ID: $id, Title: $title, Desc: $desc, Rating: $rating, Item Categories: $itemCategories)\nItems: $items";
}
