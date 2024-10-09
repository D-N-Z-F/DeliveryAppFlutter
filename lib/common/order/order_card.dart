import 'package:delivery_app_flutter/common/order/item_card_3.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/models/order.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = <Item, int>{};
    for (final item in order.cart.items) {
      items[item] = (items[item] ?? 0) + 1;
    }
    return Card(
      color: Colors.grey[50],
      margin: const EdgeInsets.all(Sizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadiusSm),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: Sizes.sm),
              child: Text(
                order.dateCreated,
                style: const TextStyle(
                  fontSize: Sizes.fontXs,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.cart.restaurantTitle),
                Text("Order Total: \$${order.total}"),
              ],
            ),
            const Divider(
              height: Sizes.dividerHeight,
              thickness: Sizes.dividerThickness,
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items.keys.elementAt(index);
                  final quantity = items[item]!;
                  return ItemCard3(
                    item: item,
                    quantity: quantity,
                    price: item.price * quantity,
                    restaurantId: order.cart.restaurantId,
                    restaurantTitle: order.cart.restaurantTitle,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
