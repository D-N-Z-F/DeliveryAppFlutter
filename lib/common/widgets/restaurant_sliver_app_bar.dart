import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_tab_bar.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/providers/favourites_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantSliverAppBar extends ConsumerWidget {
  final TabController tabController;
  final Restaurant restaurant;
  const RestaurantSliverAppBar({
    super.key,
    required this.restaurant,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final data = ref.watch(favouriteProvider(restaurant.id!));

    Future<void> addToUserFavourites() async {
      await UserRepo().updateUserFavourites(restaurant);
      ref.invalidate(favouriteProvider);
    }

    return SliverAppBar(
      iconTheme: IconThemeData(color: scheme.get(MainColors.tertiaryFixed)),
      pinned: true,
      floating: true,
      expandedHeight: 250,
      collapsedHeight: Sizes.appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1.0,
        background: Stack(
          children: [
            CachedNetworkImage(
              height: double.infinity,
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
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            fontSize: Sizes.fontLg,
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
                                fontSize: Sizes.fontLg,
                              ),
                            ),
                            const SizedBox(width: Sizes.xs),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: Sizes.iconMd,
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      restaurant.category.enumToString(),
                      style: TextStyle(
                        fontSize: Sizes.fontMd,
                        color: scheme.get(MainColors.tertiaryFixed),
                      ),
                    ),
                    const Column(
                      children: [
                        Divider(
                          indent: 5,
                          endIndent: 5,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Delivery Fee:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.fontXs),
                                ),
                                Text("RM 5",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Sizes.fontXs))
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Delivery Time:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.fontXs),
                                ),
                                Text(
                                  "15 - 30 minutes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.fontXs),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: data.when(
                data: (favourite) {
                  final isFavourited = favourite != null;
                  return IconButton(
                    icon: Icon(
                      isFavourited ? Icons.favorite : Icons.favorite_border,
                      color: isFavourited ? Colors.red : Colors.white,
                      size: 28,
                    ),
                    onPressed: addToUserFavourites,
                  );
                },
                error: (_, __) => const EmptyDisplay(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
        title: RestaurantTabBar(
          restaurant: restaurant,
          tabController: tabController,
        ),
      ),
    );
  }
}
