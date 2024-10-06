import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/cart/item_card_2.dart';
import 'package:delivery_app_flutter/common/cart/restaurant_card_2.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const route = "/cart";
  static const routeName = "Cart";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    void deleteCart() {
      ref.read(hiveProvider).deleteCartFromBox();
      ref.invalidate(cartProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Cart"),
            ElevatedButton(
              onPressed: deleteCart,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: cart.when(
        data: (data) {
          if (data == null) {
            return const EmptyDisplay(message: Strings.cartDisplayMessage);
          }
          final restaurant = ref.watch(restaurantProvider(data.restaurantId));
          return restaurant.when(
            data: (data2) {
              final items = <Item, int>{};
              for (final item in data.items) {
                debugPrint(item.toString());
                debugPrint(items.keys.toString());
                items[item] = (items[item] ?? 0) + 1;
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.sm),
                  child: Column(
                    children: [
                      RestaurantCard2(restaurant: data2!),
                      const Header(heading: "Items"),
                      items.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items.keys.elementAt(index);
                                final quantity = items[item]!;
                                return ItemCard2(
                                  item: item,
                                  quantity: quantity,
                                  price: item.price * quantity,
                                );
                              },
                            )
                          : const EmptyDisplay(
                              message: "No items found. Go add some!",
                            ),
                    ],
                  ),
                ),
              );
            },
            error: (_, __) =>
                const EmptyDisplay(message: Strings.cartDisplayMessage),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        error: (_, __) =>
            const EmptyDisplay(message: Strings.cartDisplayMessage),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
