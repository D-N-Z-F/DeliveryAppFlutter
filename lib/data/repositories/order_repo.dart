import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app_flutter/data/models/order.dart' as models;
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';

class OrderRepo {
  static final OrderRepo _instance = OrderRepo._init();
  factory OrderRepo() => _instance;
  OrderRepo._init();

  final _collection = FirebaseFirestore.instance.collection("orders");

  Stream<List<models.Order>> getAllOrders() =>
      _collection.snapshots().map((event) => event.docs
          .map((doc) => models.Order.fromMap(doc.data()).copy(id: doc.id))
          .where((order) => order.cart.userId == UserRepo().getUid())
          .toList());

  Future<models.Order?> getOrderById(String id) async {
    final order = await Helpers.globalErrorHandler(() async {
      final snapshot = await _collection.doc(id).get();
      return snapshot.exists
          ? models.Order.fromMap(snapshot.data()!).copy(id: snapshot.id)
          : null;
    });
    return order;
  }

  Future<void> createOrder(models.Order order) async =>
      await Helpers.globalErrorHandler(() => _collection.add(order.toMap()));

  Future<void> updateOrder(String id, models.Order order) async =>
      await Helpers.globalErrorHandler(
        () => _collection.doc(id).set(order.toMap()),
      );

  Future<void> deleteOrder(String id) async =>
      await Helpers.globalErrorHandler(() => _collection.doc(id).delete());
}
