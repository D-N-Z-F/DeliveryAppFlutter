import 'package:delivery_app_flutter/common/home/home_categories.dart';
import 'package:delivery_app_flutter/common/home/home_recommended.dart';
import 'package:delivery_app_flutter/common/home/home_restaurants.dart';
import 'package:delivery_app_flutter/common/home/home_sliver_app_bar.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/data/providers/theme_provider.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = "/home";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    ref.read(themeProvider.notifier).checkForSavedTheme();
    return Scaffold(
      backgroundColor: scheme.get(MainColors.surface),
      body: const CustomScrollView(
        slivers: [
          HomeSliverAppBar(),
          HomeCategories(),
          HomeRecommended(),
          // HomeRestaurants Title
          SliverToBoxAdapter(
            child: Center(child: Header(heading: "All Restaurants")),
          ),
          HomeRestaurants(),
        ],
      ),
    );
  }
}
