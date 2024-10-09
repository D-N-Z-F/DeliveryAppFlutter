import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';

import 'package:delivery_app_flutter/data/providers/theme_provider.dart';
import 'package:delivery_app_flutter/utils/constants/themes.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Header(heading: "Settings", omitMargin: true),
        backgroundColor: scheme.get(MainColors.surface),
      ),
      backgroundColor: scheme.get(MainColors.surface),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: scheme.get(MainColors.primary),
              borderRadius: BorderRadius.circular(Sizes.sm),
            ),
            margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.get(MainColors.tertiary),
                  ),
                ),
                CupertinoSwitch(
                  value: ref.watch(themeProvider) == darkTheme,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).toggleTheme();
                    MyApp.showSnackBar(
                      content: "Settings updated.",
                      seconds: 1,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
                  CupertinoSwitch(
                      value: ref.watch(themeProvider) == darkTheme,
                      onChanged: (value) {
                        ref.read(themeProvider.notifier).toggleTheme();
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
