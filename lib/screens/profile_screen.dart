import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";
  static const routeName = "Profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _navigateToSettings() {
    context.push(SettingsScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = UserRepo();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0)),
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              padding: const EdgeInsets.all(15),
              child: const Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.person_2, size: 70)),
                  Expanded(child: Text("Name"))
                ],
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
                            borderRadius: BorderRadius.circular(20))),
                    child: const Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(children: [
                              Icon(Icons.receipt),
                              Text("Order History")
                            ])),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(children: [
                              Icon(Icons.favorite),
                              Text("Favorites")
                            ])),
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
                          borderRadius: BorderRadius.circular(10))),
                  child: const Padding(
                      padding: EdgeInsets.only(
                          left: 5, top: 20, right: 5, bottom: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.settings),
                          ),
                          Text("Settings")
                        ],
                      ))),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: OutlinedButton(
                  onPressed: userRepo.logout,
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Padding(
                      padding: EdgeInsets.only(
                          left: 5, top: 20, right: 5, bottom: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.logout),
                          ),
                          Text("Logout")
                        ],
                      ))),
            )
          ],
        ));
  }
}
