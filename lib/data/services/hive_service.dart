// Local Storage
import 'dart:convert';

import 'package:delivery_app_flutter/data/models/cart.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  late Box _box;
  static const _boxName = "normalBox";

  Future<void> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) _box = await Hive.openBox(_boxName);
  }

  String? getUid() => UserRepo().getUid();

//Cart Methods------------------------------------------------------------------

  Future<Cart?> getCartFromBox() async {
    await openBox();
    final id = getUid();
    final jsonString = await _box.get("$id/cart");
    if (jsonString != null) {
      final Map<String, dynamic> cartMap = jsonDecode(jsonString);
      return Cart.fromMap(cartMap);
    }
    return null;
  }

  Future<void> updateCartInBox(Cart cart) async {
    await openBox();
    final id = getUid();
    final jsonString = jsonEncode(cart.toMap());
    await _box.put("$id/cart", jsonString);
  }

  Future<void> deleteCartFromBox() async {
    await openBox();
    final id = getUid();
    await _box.delete("$id/cart");
  }

//Cart Methods------------------------------------------------------------------

//RecentSearch Methods----------------------------------------------------------

  Future<List<Restaurant>> getRecentsFromBox() async {
    await openBox();
    final id = getUid();
    final jsonString = await _box.get("$id/recents");
    List<Restaurant> recents = [];
    if (jsonString != null) {
      final List<dynamic> restaurants = jsonDecode(jsonString);
      recents = restaurants
          .map(
            (restaurantMap) =>
                Restaurant.fromMap(restaurantMap as Map<String, dynamic>),
          )
          .toList();
    }
    return recents;
  }

  Future<void> updateRecentsInBox(Restaurant restaurant) async {
    await openBox();
    final id = getUid();
    final recents = await getRecentsFromBox();
    recents.remove(restaurant);
    recents.add(restaurant);
    if (recents.length > 10) recents.removeAt(0);
    final jsonString = jsonEncode(
      recents.map((restaurant) => restaurant.toMap()).toList(),
    );
    await _box.put("$id/recents", jsonString);
  }

  Future<void> deleteRecentsFromBox() async {
    await openBox();
    final id = getUid();
    await _box.delete("$id/recents");
  }

//RecentSearch Methods----------------------------------------------------------

//Theme Methods-----------------------------------------------------------------

  Future<String> getAppThemeFromBox() async {
    await openBox();
    final id = getUid();
    return await _box.get("$id/theme", defaultValue: "lightTheme");
  }

  Future<void> updateAppThemeInBox(String theme) async {
    await openBox();
    final id = getUid();
    await _box.put("$id/theme", theme);
  }

//Theme Methods-----------------------------------------------------------------

  Future<void> clearBox() async => await _box.clear();
}

final hiveProvider = Provider((ref) => HiveService());
