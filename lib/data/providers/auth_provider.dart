import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<bool> {
  AuthProvider() : super(false) {
    checkAuthStatus();
  }

  void checkAuthStatus() => FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) => state = user != null);
}

final authProvider = StateNotifierProvider<AuthProvider, bool>(
  (ref) => AuthProvider(),
);

final authStateProvider = StateProvider<bool>((ref) => false);

final updateStateProvider = StateProvider<bool>((ref) => false);
