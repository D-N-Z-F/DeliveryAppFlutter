import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantCard2 extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard2({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    void navigateToRestaurant() {
      context.pushNamed(
        RestaurantScreen.routeName,
        pathParameters: {"id": restaurant.id!},
      );
    }

    return GestureDetector(
      onTap: navigateToRestaurant,
      child: Card(
        margin: const EdgeInsets.all(Sizes.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusSm),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                Sizes.cardRadiusSm,
              ),
              child: CachedNetworkImage(
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: restaurant.imageUrl,
                placeholder: (context, url) => const DefaultImage(
                  filePath: Strings.defaultRestaurantImagePath,
                ),
                errorWidget: (context, url, error) => const DefaultImage(
                  filePath: Strings.defaultRestaurantImagePath,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    Sizes.cardRadiusSm,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Helpers.truncateText(restaurant.title, 21),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.fontMd,
                            color: scheme.get(MainColors.tertiaryFixed),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.rating
                                  .clamp(0.0, 5.0)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                color: scheme.get(MainColors.tertiaryFixed),
                              ),
                            ),
                            const SizedBox(width: Sizes.xs),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: Sizes.iconSm,
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      restaurant.category.enumToString(),
                      style: TextStyle(
                        fontSize: Sizes.fontXs,
                        color: scheme.get(MainColors.tertiaryFixed),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
