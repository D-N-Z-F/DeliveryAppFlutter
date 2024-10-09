import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/data/models/cart.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemBottomSheet extends ConsumerWidget {
  final Item item;
  final String restaurantId;
  final String restaurantTitle;
  ItemBottomSheet({
    super.key,
    required this.item,
    required this.restaurantId,
    required this.restaurantTitle,
  });
  final _counterProvider = StateProvider<int>((ref) => 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(_counterProvider);
    final scheme = Theme.of(context).colorScheme;
    final hive = HiveService();
    final userRepo = UserRepo();

    Future<Cart> getCartForRestaurant() async {
      Cart? cart = await hive.getCartFromBox();
      if (cart != null && cart.restaurantId != restaurantId) {
        await hive.deleteCartFromBox();
        return Cart(
          userId: userRepo.getUid()!,
          restaurantId: restaurantId,
          restaurantTitle: restaurantTitle,
        );
      }
      return cart ??= Cart(
        userId: userRepo.getUid()!,
        restaurantId: restaurantId,
        restaurantTitle: restaurantTitle,
      );
    }

    Future<void> addItemToCart(int counter) async {
      Cart cart = await getCartForRestaurant();
      final existingItemCount =
          cart.items.where((item) => item == this.item).length;

      if (existingItemCount >= 10) {
        return;
      }
      final items = List<Item>.from(cart.items);
      for (int i = 0; i < counter; i++) {
        items.add(item);
      }
      cart = cart.copy(items: items);
      await hive.updateCartInBox(cart);
      ref.invalidate(cartProvider);
      if (context.mounted) Navigator.pop(context);
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.cardRadiusLg),
            topRight: Radius.circular(Sizes.cardRadiusLg),
          ),
          child: CachedNetworkImage(
            height: 200,
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
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Sizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Helpers.truncateText(item.title, 21),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.fontMd,
                      ),
                    ),
                    Text(
                      "\$ ${item.price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: Sizes.sm),
                  child: Text(item.desc),
                ),
              ],
            ),
          ),
        ),
        Text("Quantity To Be Added: $counter"),
        Container(
          margin: const EdgeInsets.all(Sizes.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => counter > 0
                    ? ref.read(_counterProvider.notifier).state--
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.get(MainColors.secondary),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.sm),
                      bottomLeft: Radius.circular(Sizes.sm),
                    ),
                  ),
                ),
                child: const Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: () => addItemToCart(counter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.get(MainColors.secondary),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
              ElevatedButton(
                onPressed: () => counter < 10
                    ? ref.read(_counterProvider.notifier).state++
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.get(MainColors.secondary),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Sizes.sm),
                      bottomRight: Radius.circular(Sizes.sm),
                    ),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        )
      ],
    );
  }
}
