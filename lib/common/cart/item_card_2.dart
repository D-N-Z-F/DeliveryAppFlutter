import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/common/widgets/item_bottom_sheet.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCard2 extends ConsumerWidget {
  final Item item;
  final int quantity;
  final double price;
  final String restaurantId;
  final String restaurantTitle;
  const ItemCard2({
    super.key,
    required this.item,
    required this.quantity,
    required this.price,
    required this.restaurantId,
    required this.restaurantTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    void removeItemFromCart() async {
      final hive = HiveService();
      final cart = await hive.getCartFromBox();
      if (cart != null) {
        final items = cart.items;
        items.removeWhere((item) => item == this.item);
        await hive.updateCartInBox(cart.copy(items: items));
        ref.invalidate(cartProvider);
      }
    }

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(Sizes.cardRadiusLg)),
        ),
        builder: (context) => ItemBottomSheet(
          item: item,
          restaurantId: restaurantId,
          restaurantTitle: restaurantTitle,
        ),
      ),
      child: Card(
        color: scheme.get(MainColors.secondary),
        margin: const EdgeInsets.all(Sizes.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusSm),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  height: 75,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: item.imageUrl,
                  placeholder: (context, url) => const DefaultImage(
                    filePath: Strings.defaultItemImagePath,
                  ),
                  errorWidget: (context, url, error) => const DefaultImage(
                    filePath: Strings.defaultItemImagePath,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title),
                        Text(
                          "Quantity: $quantity",
                          style: const TextStyle(fontSize: Sizes.fontXs),
                        )
                      ],
                    ),
                    Text(
                      "\$ ${price.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: Sizes.sm),
              child: ElevatedButton.icon(
                onPressed: removeItemFromCart,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 40),
                  maximumSize: const Size(40, 40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: scheme.get(MainColors.surface),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.sm),
                  ),
                ),
                label: Icon(
                  Icons.delete,
                  color: scheme.get(MainColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
