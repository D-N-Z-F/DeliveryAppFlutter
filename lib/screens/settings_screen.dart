import 'package:delivery_app_flutter/state_management/theme/theme.dart';
import 'package:delivery_app_flutter/state_management/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  static const route = "/settings";
  static const routeName = "Settings";

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0)),
              margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  CupertinoSwitch(
                      value: ref.watch(themeProvider) == darkTheme,
                      onChanged: (value) {
                        ref.read(themeProvider.notifier).toggleTheme();
                      })
                ],
              ),
            )
          ],
        ));
  }
}
