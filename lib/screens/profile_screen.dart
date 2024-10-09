import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/data/providers/user_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/screens/favourites_screen.dart';
import 'package:delivery_app_flutter/screens/order_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/update_profile_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";
  static const routeName = "Profile";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final userRepo = UserRepo();

  void _navigateToSettings() {
    context.push(SettingsScreen.route);
  }

  void navigateToUpdateProfile() {
    context.push(UpdateProfileScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final data = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Header(heading: "Profile", omitMargin: true),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: scheme.get(MainColors.primary),
                borderRadius: BorderRadius.circular(12.0)),
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            padding: const EdgeInsets.all(15),
            child: data.when(
              data: (user) => user == null
                  ? const EmptyDisplay(message: Strings.userDisplayMessage)
                  : Row(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Header(
                                heading: user.username,
                                omitMargin: true,
                                color: scheme.get(MainColors.tertiary),
                              ),
                              Text(
                                "Email: ${user.email}",
                                style: TextStyle(
                                  color: scheme.get(MainColors.tertiary),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: navigateToUpdateProfile,
                          child: Icon(
                            Icons.edit,
                            color: scheme.get(MainColors.tertiary),
                          ),
                        ),
                      ],
                    ),
              error: (_, __) => const EmptyDisplay(),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => context.pushNamed(OrderScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: scheme.get(MainColors.secondary),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Icon(Icons.receipt),
                            Text("Order History")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.pushNamed(FavouritesScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: scheme.get(MainColors.secondary),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [Icon(Icons.favorite), Text("Favorites")],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: ElevatedButton(
              onPressed: _navigateToSettings,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: scheme.get(MainColors.secondary),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.settings),
                    ),
                    Text("Settings")
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ElevatedButton(
              onPressed: userRepo.logout,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: scheme.get(MainColors.secondary),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.logout),
                    ),
                    Text("Logout")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
