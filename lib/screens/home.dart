import 'package:delivery_app_flutter/screens/customer_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = "/";
  static const routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToMerchantScreen() {
    context.push(CustomerOrderScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      floatingActionButton: FloatingActionButton(
          onPressed: _navigateToMerchantScreen, child: const Icon(Icons.add)),
      body: const Center(
        child: Text("Welcome to Home Screen"),
      ),
    );
  }
}
