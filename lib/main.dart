import 'package:delivery_app_flutter/data/providers/router_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/data/services/notification_service.dart';
import 'package:delivery_app_flutter/data/services/stripe_service.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/data/providers/theme_provider.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:delivery_app_flutter/screens/auth.dart';
import 'package:delivery_app_flutter/screens/cart_screen.dart';
import 'package:delivery_app_flutter/screens/categories_screen.dart';
import 'package:delivery_app_flutter/screens/checkout_screen.dart';
import 'package:delivery_app_flutter/screens/favourites_screen.dart';
import 'package:delivery_app_flutter/screens/order_screen.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/login.dart';
import 'package:delivery_app_flutter/screens/register.dart';
import 'package:delivery_app_flutter/screens/profile_screen.dart';
import 'package:delivery_app_flutter/screens/settings_screen.dart';
import 'package:delivery_app_flutter/screens/tab_container_screen.dart';
import 'package:delivery_app_flutter/data/providers/theme_provider.dart';
import 'package:delivery_app_flutter/screens/update_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  await setupHive();
  await setupNotification();
  await setupWorkManager();
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await setupDotEnv();
  await setupStripe();
  runApp(const ProviderScope(child: MyApp()));
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final status = DeliveryStatusHelpers.stringToEnum(
      inputData!["status"].toString(),
    ).getStatusText();
    await NotificationService.showNotification(taskName, status);
    return Future.value(true);
  });
}

Future<void> setupWorkManager() async => await Workmanager().initialize(
      callbackDispatcher,
    );
Future<void> setupNotification() async {
  await NotificationService.init();
  tz.initializeTimeZones();
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  await HiveService().openBox();
  // await HiveService().clearBox();
}

Future<void> setupFirebase() async => await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
Future<void> setupDotEnv() async => await dotenv.load(fileName: ".env");
Future<void> setupStripe() async => await StripeService().init();

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
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
      GoRoute(
        path: RestaurantScreen.route,
        name: RestaurantScreen.routeName,
        builder: (context, state) => RestaurantScreen(
          id: state.pathParameters["id"]!,
        ),
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
        builder: (context, state) => UpdateProfileScreen(
          id: state.pathParameters["id"]!,
        ),
      ),
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

  static void showSnackBar({
    required String content,
    SnackBarTheme theme = SnackBarTheme.info,
    Color color = MyColors.info,
    int seconds = 2,
  }) =>
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Row(
            children: [
              Icon(theme.get(), color: Colors.white),
              const SizedBox(width: 8),
              Text(Helpers.truncateText(content, 42)),
            ],
          ),
          duration: Duration(seconds: seconds),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeData = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Delivery App',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(routes: routes, initialLocation: LoginScreen.route),
      theme: themeData,
      darkTheme: themeData,
      routerConfig: router,
    );
  }
}
