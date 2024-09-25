import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/tab_container_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final routes = [
    GoRoute(
      path: TabContainerScreen.route,
      name: TabContainerScreen.routeName,
      builder: (context, state) => const TabContainerScreen(),
    ),
    GoRoute(
      path: HomeScreen.route,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: SettingsScreen.route,
      name: SettingsScreen.routeName,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: ProfileScreen.route,
      name: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),
  ];

  static SnackBar actionSnackbarBuilder(
          BuildContext context, String action, bool isSuccessful) =>
      SnackBar(
        content: Text("$action ${isSuccessful ? "" : "un"}successful."),
        duration: const Duration(seconds: 2),
      );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Delivery App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          useMaterial3: true),
      darkTheme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          useMaterial3: true),
      routerConfig: GoRouter(routes: routes, initialLocation: TabContainerScreen.route),
    );
  }
}
