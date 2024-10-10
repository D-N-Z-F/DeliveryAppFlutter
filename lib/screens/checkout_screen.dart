import 'package:delivery_app_flutter/common/cart/item_card_2.dart';
import 'package:delivery_app_flutter/common/cart/address_card.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/order/price_summary.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/providers/restaurant_provider.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  static const route = "/checkout";
  static const routeName = "checkout";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Screen"),
      ),
      body: data.when(
        data: (cart) => cart == null
            ? const EmptyDisplay(message: Strings.defaultErrorMessage)
            : ref.watch(restaurantProvider(cart.restaurantId)).when(
                  data: (restaurant) {
                    final items = <Item, int>{};
                    for (final item in cart.items) {
                      items[item] = (items[item] ?? 0) + 1;
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.sm),
                        child: items.isNotEmpty
                            ? Column(
                                children: [
                                  const AddressCard(),
                                  const Header(heading: "Items"),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = items.keys.elementAt(index);
                                      final quantity = items[item]!;
                                      final price = item.price * quantity;
                                      return ItemCard2(
                                        item: item,
                                        quantity: quantity,
                                        price: price,
                                        restaurantId: restaurant!.id!,
                                        restaurantTitle: restaurant.title,
                                      );
                                    },
                                  ),
                                  PriceSummary(items: items),
                                ],
                              )
                            : const EmptyDisplay(
                                message: "No items found. Go add some!",
                              ),
                      ),
                    );
                  },
                  error: (_, __) =>
                      const EmptyDisplay(message: Strings.defaultErrorMessage),
                  loading: () => const Center(child: LoadingIndicator()),
                ),
        error: (_, __) =>
            const EmptyDisplay(message: Strings.defaultErrorMessage),
        loading: () => const Center(child: LoadingIndicator()),
      ),
    );
  }
}
