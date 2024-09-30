import 'package:delivery_app_flutter/common/widgets/my_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = "/home";
  static const routeName = "Home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const CustomScrollView(
        slivers: [MySliverAppBar()],
      ),
    );
  }
}
