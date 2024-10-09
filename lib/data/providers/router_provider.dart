import 'package:delivery_app_flutter/data/providers/auth_provider.dart';
import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/categories_screen.dart';
import 'package:delivery_app_flutter/screens/checkout_screen.dart';
import 'package:delivery_app_flutter/screens/favourites_screen.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/auth.dart';
import 'package:delivery_app_flutter/screens/order_screen.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/tab_container_screen.dart';
import 'package:delivery_app_flutter/screens/update_profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
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
      GoRoute(
        path: RestaurantScreen.route,
        name: RestaurantScreen.routeName,
        builder: (context, state) => RestaurantScreen(
          id: state.pathParameters["id"]!,
        ),
      ),
      GoRoute(
        path: CheckoutScreen.route,
        name: CheckoutScreen.routeName,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: OrderScreen.route,
        name: OrderScreen.routeName,
        builder: (context, state) => const OrderScreen(),
      ),
      GoRoute(
        path: FavouritesScreen.route,
        name: FavouritesScreen.routeName,
        builder: (context, state) => const FavouritesScreen(),
      ),
      GoRoute(
        path: CategoriesScreen.route,
        name: CategoriesScreen.routeName,
        builder: (context, state) => CategoriesScreen(
          name: state.pathParameters["name"]!,
        ),
      ),
      GoRoute(
        path: UpdateProfileScreen.route,
        name: UpdateProfileScreen.routeName,
        builder: (context, state) => const UpdateProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.watch(authProvider);
      final onAuthScreen = state.name == AuthScreen.routeName;
      if (isLoggedIn && onAuthScreen) return HomeScreen.route;
      if (!isLoggedIn && !onAuthScreen) return AuthScreen.route;
      return null;
    },
  ),
);
