// Local Storage
import 'dart:convert';

import 'package:delivery_app_flutter/data/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveService {
  HiveService() {
    _openBox();
  }
  late Box _box;
  static const _boxName = "cartBox";

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) _box = await Hive.openBox(_boxName);
  }

  Future<Cart?> getCartFromBox(String userId) async {
    await _openBox();
    final jsonString = await _box.get(userId);
    if (jsonString != null) {
      final Map<String, dynamic> cartMap = jsonDecode(jsonString);
      debugPrint("hive_service.dart\n$cartMap");
      return Cart.fromMap(cartMap);
    }
    return null;
  }

  Future<void> updateCartInBox(String userId, Cart cart) async {
    await _openBox();
    final jsonString = jsonEncode(cart.toMap());
    await _box.put(userId, jsonString);
  }

  Future<void> deleteCartFromBox(String userId) async {
    await _openBox();
    await _box.delete(userId);
  }

  Future<void> clearBox() async => await _box.clear();
}
