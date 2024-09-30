import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabContainerScreen extends StatefulWidget {
  const TabContainerScreen({super.key});

  static const route = "/";
  static const routeName = "TabContainer";
  @override
  State<TabContainerScreen> createState() => _TabContainerScreenState();
}

class _TabContainerScreenState extends State<TabContainerScreen> {
 

  void _navigateToProfile() {
    context.push(ProfileScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(children: [HomeScreen(),SearchScreen(), CartScreen(), ProfileScreen()]),
          bottomNavigationBar: TabBar(padding: EdgeInsets.all(10.0), tabs: [
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
            )
          ]),
        ));
  }
}
