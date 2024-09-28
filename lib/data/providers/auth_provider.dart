import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<bool> {
  AuthProvider() : super(false) {
    checkAuthStatus();
    debugPrint("HAAAAAAAAAA");
  }

  // void signIn() => state = true;
  // void signOut() => state = false;

  void checkAuthStatus() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) => state = user != null);
  }
}

final authProvider =
    StateNotifierProvider<AuthProvider, bool>((ref) => AuthProvider());
