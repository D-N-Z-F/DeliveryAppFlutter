import 'dart:math';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/providers/auth_provider.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/screens/auth.dart';
import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/tab_container_screen.dart';
import 'package:delivery_app_flutter/state_management/theme/theme_provider.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await test();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> test() async {
  final restaurantRepo = RestaurantRepo();
  var counter = 0;
  while (counter < 10) {
    final random = Random();
    final ranDouble = (random.nextDouble() * 5.0);
    final ranInt = random.nextInt(Categories.values.length);
    await restaurantRepo.createRestaurant(Restaurant(
        title: "title $counter",
        desc: "desc $counter",
        rating: ranDouble,
        category: Categories.values[ranInt],
        itemCategories: ["category $counter"]));
    counter++;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
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
    redirect: (context, state) {
      final isLoggedIn = ref.watch(authProvider);
      final onAuthScreen = state.name == AuthScreen.routeName;
      if (isLoggedIn && onAuthScreen) return HomeScreen.route;
      if (!isLoggedIn && !onAuthScreen) return AuthScreen.route;
      return null;
    },
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
      theme: themeData,
      darkTheme: themeData,
      routerConfig: router,
    );
  }
}
