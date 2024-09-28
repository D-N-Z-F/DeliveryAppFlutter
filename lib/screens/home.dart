import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = "/";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = UserRepo();
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome to Home Screen"),
            ElevatedButton(
              onPressed: userRepo.logout,
              child: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
