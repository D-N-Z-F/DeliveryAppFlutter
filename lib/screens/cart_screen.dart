import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/cart/item_card_2.dart';
import 'package:delivery_app_flutter/common/cart/restaurant_card_2.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/screens/checkout_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const route = "/cart";
  static const routeName = "Cart";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(cartProvider);
    final scheme = Theme.of(context).colorScheme;

    void deleteCart() {
      ref.read(hiveProvider).deleteCartFromBox();
      ref.invalidate(cartProvider);
    }

    void navigateToCheckoutScreen() {
      context.pushNamed(CheckoutScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Header(heading: "Cart", omitMargin: true),
            ElevatedButton(
              onPressed: deleteCart,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: scheme.get(MainColors.secondary),
              ),
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: data.when(
        data: (cart) => cart == null
            ? const EmptyDisplay(message: Strings.cartDisplayMessage)
            : ref.watch(restaurantProvider(cart.restaurantId)).when(
                  data: (restaurant) {
                    final items = <Item, int>{};
                    for (final item in cart.items) {
                      items[item] = (items[item] ?? 0) + 1;
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.sm),
                        child: Column(
                          children: [
                            RestaurantCard2(restaurant: restaurant!),
                            const Header(heading: "Items"),
                            items.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = items.keys.elementAt(index);
                                      final quantity = items[item]!;
                                      return ItemCard2(
                                        item: item,
                                        quantity: quantity,
                                        price: item.price * quantity,
                                        restaurantId: restaurant.id!,
                                        restaurantTitle: restaurant.title,
                                      );
                                    },
                                  )
                                : const EmptyDisplay(
                                    message: "No items found. Go add some!",
                                  ),
                            if (items.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: Sizes.md),
                                child: ElevatedButton(
                                  onPressed: navigateToCheckoutScreen,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        scheme.get(MainColors.secondary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(Sizes.sm),
                                    ),
                                  ),
                                  child: Text(
                                    "Proceed To Checkout",
                                    style: TextStyle(
                                      color: scheme.get(MainColors.primary),
                                    ),
                                  ),
                                ),
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
                ),
        error: (_, __) =>
            const EmptyDisplay(message: Strings.cartDisplayMessage),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
