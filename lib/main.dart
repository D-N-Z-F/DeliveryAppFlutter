import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/login.dart';
import 'package:delivery_app_flutter/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final routes = [
    GoRoute(
      path: HomeScreen.route,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen()),
        GoRoute(
        path: RegisterScreen.route,
        name: RegisterScreen.routeName,
        builder: (context, state) => const RegisterScreen())
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(routes: routes, initialLocation: LoginScreen.route),
    );
  }
}
