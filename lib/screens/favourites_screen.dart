import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/common/widgets/restaurant_card.dart';
import 'package:delivery_app_flutter/data/providers/favourites_provider.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  static const route = "/favourites";
  static const routeName = "Favourites";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(favouritesProvider);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Header(heading: "Your Favourites", omitMargin: true),
      ),
      body: data.when(
        data: (favourites) {
          return favourites.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(Sizes.sm),
                  child: ListView.builder(
                    itemCount: favourites.length,
                    itemBuilder: (context, index) => RestaurantCard(
                      restaurant: favourites[index],
                    ),
                  ),
                )
              : const EmptyDisplay();
        },
        error: (_, __) => const EmptyDisplay(),
        loading: () => const Center(child: LoadingIndicator()),
      ),
    );
  }
}
