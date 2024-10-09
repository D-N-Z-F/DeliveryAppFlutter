import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/data/providers/user_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/update_profile_screen.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
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
          title: const Text("Profile"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(12.0)),
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              padding: const EdgeInsets.all(15),
              child: data.when(
                data: (user) {
                  if (user == null) {
                    return const Text("User not found");
                  }
                  return Row(
                    children: [
                      SizedBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: const TextStyle(fontSize: Sizes.fontLg),
                          ),
                          Text("Email: ${user.email}")
                        ],
                      )),
                      const Spacer(),
                      GestureDetector(
                        onTap: navigateToUpdateProfile,
                        child: Icon(
                          Icons.edit,
                          size: Sizes.icon["lg"],
                        ),
                      )
                    ],
                  );
                },
                error: (_, __) => const EmptyDisplay(),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                  OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
              child: OutlinedButton(
                onPressed: _navigateToSettings,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
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
              child: OutlinedButton(
                onPressed: userRepo.logout,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
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
        ));
  }
}
