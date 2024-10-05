// Local Storage
import 'dart:convert';

import 'package:delivery_app_flutter/data/models/cart.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
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

//User Methods------------------------------------------------------------------
  Future<String> getUserIdFromBox() async {
    await openBox();
    final id = await _box.get(Strings.userToken);
    return id.toString();
  }

  Future<void> updateUserIdInBox(String userId) async {
    await openBox();
    await _box.put(Strings.userToken, userId);
    debugPrint(await getUserIdFromBox());
  }

  Future<void> removeUserIdInBox() async {
    await openBox();
    await _box.delete(Strings.userToken);
    debugPrint(await getUserIdFromBox());
  }
//User Methods------------------------------------------------------------------

//Cart Methods------------------------------------------------------------------

  Future<Cart?> getCartFromBox() async {
    await openBox();
    final id = await getUserIdFromBox();
    final jsonString = await _box.get(id);
    if (jsonString != null) {
      final Map<String, dynamic> cartMap = jsonDecode(jsonString);
      debugPrint("hive_service.dart\n$cartMap");
      return Cart.fromMap(cartMap);
    }
    return null;
  }

  Future<void> updateCartInBox(Cart cart) async {
    await openBox();
    final id = await getUserIdFromBox();
    final jsonString = jsonEncode(cart.toMap());
    await _box.put(id, jsonString);
  }

  Future<void> deleteCartFromBox() async {
    await openBox();
    final id = await getUserIdFromBox();
    await _box.delete(id);
  }

//Cart Methods------------------------------------------------------------------

  Future<void> clearBox() async => await _box.clear();
}
