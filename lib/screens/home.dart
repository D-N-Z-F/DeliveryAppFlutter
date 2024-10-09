import 'package:delivery_app_flutter/screens/login.dart';
import 'package:delivery_app_flutter/common/home/home_categories.dart';
import 'package:delivery_app_flutter/common/home/home_recommended.dart';
import 'package:delivery_app_flutter/common/home/home_restaurants.dart';
import 'package:delivery_app_flutter/common/home/home_sliver_app_bar.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = "/home";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context) {
    void _navigateToLogin() {
      context.push(LoginScreen.route);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: OutlinedButton(
            onPressed: () => _navigateToLogin(), child: const Text("Login")),
    final scheme = Theme.of(context).colorScheme;

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
