import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({super.key});

  static const route = "/";
  static const routeName = "TabContainer";

  @override
  Widget build(BuildContext context) {
    const viewList = [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    final tabList = [
      Container(
        padding: const EdgeInsets.only(top: Sizes.xs),
        height: 50.0,
        child: const Column(
          children: [Icon(Icons.home), Text("Home")],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: Sizes.xs),
        height: 50.0,
        child: const Column(
          children: [Icon(Icons.search), Text("Search")],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: Sizes.xs),
        height: 50.0,
        child: const Column(
          children: [Icon(Icons.shopping_cart_outlined), Text("Cart")],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: Sizes.xs),
        height: 50.0,
        child: const Column(
          children: [Icon(Icons.person), Text("Profile")],
        ),
      ),
    ];
    return DefaultTabController(
      length: viewList.length,
      animationDuration: const Duration(milliseconds: 500),
      child: Scaffold(
        body: const TabBarView(children: viewList),
        bottomNavigationBar: TabBar(tabs: tabList),
      ),
    );
  }
}
