import 'package:delivery_app_flutter/data/models/order.dart';
import 'package:delivery_app_flutter/data/repositories/order_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider((ref) => OrderRepo());

final ordersProvider = StreamProvider(
  (ref) => ref.watch(repoProvider).getAllOrders(),
);

final orderProvider = FutureProvider.family<Order?, String>(
  (ref, orderId) => ref.watch(repoProvider).getOrderById(orderId),
);
