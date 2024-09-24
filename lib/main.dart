import 'package:delivery_app_flutter/screens/auth.dart';
import 'package:delivery_app_flutter/state_management/auth_state.dart';
import 'package:delivery_app_flutter/state_management/auth_notifier.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(const Duration(seconds: 2));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final routerProvider = Provider<GoRouter>((ref) {
    final authProvider =
        StateNotifierProvider<AuthNotifier, AuthState>((_) => AuthNotifier());
    final authState = ref.watch(authProvider);
    return GoRouter(
      initialLocation: HomeScreen.route,
      routes: [
        GoRoute(
          path: HomeScreen.route,
          name: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AuthScreen.route,
          name: AuthScreen.routeName,
          builder: (context, state) => const AuthScreen(),
        )
      ],
      redirect: (context, state) {
        if (authState.isLoading) return null;

        final isLoggedIn = authState.isLoggedIn;
        final isLoggingIn = state.name == AuthScreen.routeName;

        if (!isLoggedIn && !isLoggingIn) return AuthScreen.route;
        if (isLoggedIn && isLoggingIn) return HomeScreen.route;

        return null;
      },
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Delivery App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          useMaterial3: true),
      darkTheme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          useMaterial3: true),
      routerConfig: router,
    );
  }
}
