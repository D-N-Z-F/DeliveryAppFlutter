import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/device_utils/device_utils.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final double widthRatio;
  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.widthRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        DeviceUtils.getDimensions(context, DimensionType.screenWidth) *
            widthRatio;
    void navigateToRestaurant(String id) async {
      context.pushNamed(RestaurantScreen.routeName, pathParameters: {"id": id});
    }

    return GestureDetector(
      onTap: () => navigateToRestaurant(restaurant.id!),
      child: Card(
        color: Colors.grey[50],
        margin: const EdgeInsets.all(Sizes.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusSm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: cardWidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
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
            ),
            SizedBox(
              width: cardWidth,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                child: Column(
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
                              fontSize: Sizes.font["md"]),
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.rating
                                  .clamp(0.0, 5.0)
                                  .toStringAsFixed(2),
                            ),
                            const SizedBox(width: Sizes.xs),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: Sizes.icon["sm"],
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      restaurant.category.enumToString(),
                      style: TextStyle(fontSize: Sizes.font["xs"]),
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
