import 'package:delivery_app_flutter/common/order/order_card.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/data/providers/order_provider.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  static const route = "/orders";
  static const routeName = "Orders";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ordersProvider);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Header(heading: "Order History", omitMargin: true),
      ),
      body: data.when(
        data: (orders) {
          return orders.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(Sizes.sm),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) => OrderCard(
                      order: orders[index],
                    ),
                  ),
                )
              : const EmptyDisplay();
        },
        error: (_, __) => const EmptyDisplay(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
