import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<bool> {
  AuthProvider() : super(false) {
    checkAuthStatus();
    debugPrint("Auth Provider Works!");
  }

  void checkAuthStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        saveUserToken(user.uid);
      } else {
        removeUserToken();
      }
      state = user != null;
    });
  }

  void saveUserToken(String id) {
    final hive = HiveService();
    hive.updateUserIdInBox(id);
  }

  void removeUserToken() {
    final hive = HiveService();
    hive.removeUserIdInBox();
  }
}

final authProvider = StateNotifierProvider<AuthProvider, bool>(
  (ref) => AuthProvider(),
);
