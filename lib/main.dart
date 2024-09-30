import 'package:delivery_app_flutter/screens/auth.dart';
import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/state_management/auth/auth_state.dart';
import 'package:delivery_app_flutter/state_management/auth/auth_notifier.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/tab_container_screen.dart';
import 'package:delivery_app_flutter/state_management/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(const Duration(seconds: 2));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

final routerProvider = Provider<GoRouter>((ref) {
  final authProvider =
      StateNotifierProvider<AuthNotifier, AuthState>((_) => AuthNotifier());
  final authState = ref.watch(authProvider);
  return GoRouter(
    initialLocation: TabContainerScreen.route,
    routes: [
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
        path: AuthScreen.route,
        name: AuthScreen.routeName,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: SearchScreen.route,
        name: SearchScreen.routeName,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: CartScreen.route,
        name: CartScreen.routeName,
        builder: (context, state) => const CartScreen(),
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
    ],
    // redirect: (context, state) {
    //   if (authState.isLoading) return null;

    //   final isLoggedIn = authState.isLoggedIn;
    //   final isLoggingIn = state.name == AuthScreen.routeName;

    //   if (!isLoggedIn && !isLoggingIn) return AuthScreen.route;
    //   if (isLoggedIn && isLoggingIn) return HomeScreen.route;

    //   return null;
    // },
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeData = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Delivery App',
      themeMode: ThemeMode.system,
      theme: themeData,
      darkTheme: themeData,
      routerConfig: router,
    );
  }
}
