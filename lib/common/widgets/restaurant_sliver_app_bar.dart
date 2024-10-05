import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/common/widgets/default_image.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_tab_bar.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class RestaurantSliverAppBar extends StatelessWidget {
  final TabController tabController;
  final Restaurant restaurant;
  const RestaurantSliverAppBar({
    super.key,
    required this.restaurant,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      iconTheme: IconThemeData(color: scheme.inversePrimary),
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
                  color: Colors.black.withOpacity(0.5),
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
                            color: scheme.inversePrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.rating
                                  .clamp(0.0, 5.0)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                color: scheme.inversePrimary,
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
                        color: scheme.inversePrimary,
                      ),
                    )
                  ],
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
