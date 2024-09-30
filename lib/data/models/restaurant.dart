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
    this.imageUrl =
        "gs://delivery-app-flutter-5608d.appspot.com/Restaurant_Card_Image.jpg",
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
        "title": title,
        "desc": desc,
        "items": items.map((item) => item.toMap()).toList(),
        "rating": rating,
        "category": category.enumToString(),
        "itemCategories": itemCategories,
        "imageUrl": imageUrl
      };

  static Restaurant fromMap(Map<String, dynamic> map) => Restaurant(
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
}
