import 'package:delivery_app_flutter/components/my_drawer_tile.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void _navigateToSettings() {
      context.push(SettingsScreen.route);
    }

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.person)),
          const Divider(),
          MyDrawerTile(
              text: "Settings",
              icon: Icons.settings,
              onTap: _navigateToSettings),
          MyDrawerTile(text: "Logout", icon: Icons.logout, onTap: () {}),
        ],
      ),
    );
  }
}
