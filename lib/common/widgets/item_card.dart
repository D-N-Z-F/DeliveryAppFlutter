import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/common/widgets/item_bottom_sheet.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final String restaurantId;
  final String restaurantTitle;
  const ItemCard({
    super.key,
    required this.item,
    required this.restaurantId,
    required this.restaurantTitle,
  });

  @override
  Widget build(BuildContext context) {
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
        color: Colors.grey[50],
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
                    Text(item.title),
                    Text(
                      "\$ ${item.price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
