import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/providers/favourites_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/device_utils/device_utils.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RestaurantCard extends ConsumerWidget {
  final Restaurant restaurant;
  final double widthRatio;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.widthRatio = 1.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final cardWidth =
        DeviceUtils.getDimensions(context, DimensionType.screenWidth) *
            widthRatio;
    final data = ref.watch(favouriteProvider(restaurant.id!));
    void navigateToRestaurant(String id) async {
      context.pushNamed(RestaurantScreen.routeName, pathParameters: {"id": id});
    }

    Future<void> addToUserFavourites() async {
      await UserRepo().updateUserFavourites(restaurant);
      ref.invalidate(favouriteProvider);
    }

    return GestureDetector(
      onTap: () => navigateToRestaurant(restaurant.id!),
      child: Card(
        color: scheme.get(MainColors.secondary),
        margin: const EdgeInsets.all(Sizes.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusSm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
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
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: addToUserFavourites,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: data.when(
                      data: (favourite) {
                        final isFavourited = favourite != null;
                        return Icon(
                          isFavourited ? Icons.favorite : Icons.favorite_border,
                          color: isFavourited ? Colors.red : Colors.grey,
                          size: 24,
                        );
                      },
                      error: (_, __) => const EmptyDisplay(),
                      loading: () => const Center(child: LoadingIndicator()),
                    ),
                  ),
                ),
              ),
            ]),
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
