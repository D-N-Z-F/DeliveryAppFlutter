import 'package:delivery_app_flutter/screens/login.dart';
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
      ),
    );
  }
}
