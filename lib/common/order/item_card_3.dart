import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ItemCard3 extends StatelessWidget {
  final Item item;
  final int quantity;
  final double price;
  final String restaurantId;
  final String restaurantTitle;
  const ItemCard3({
    super.key,
    required this.item,
    required this.quantity,
    required this.price,
    required this.restaurantId,
    required this.restaurantTitle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.get(MainColors.surface),
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
                    "\$ $price",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
