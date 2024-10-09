import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:flutter/material.dart';

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({super.key});

  static const route = "/";
  static const routeName = "TabContainer";

  final viewList = const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final tabList = const [
    SizedBox(
      height: 50.0,
      child: Column(
        children: [Icon(Icons.home), Text("Home")],
      ),
    ),
    SizedBox(
      height: 50.0,
      child: Column(
        children: [Icon(Icons.search), Text("Search")],
      ),
    ),
    SizedBox(
      height: 50.0,
      child: Column(
        children: [Icon(Icons.shopping_cart_outlined), Text("Cart")],
      ),
    ),
    SizedBox(
      height: 50.0,
      child: Column(
        children: [Icon(Icons.person), Text("Profile")],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: viewList.length,
        child: Scaffold(
          body: TabBarView(children: viewList),
          bottomNavigationBar: TabBar(tabs: tabList),
        ));
  }
}
