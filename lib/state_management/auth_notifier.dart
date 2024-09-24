import 'package:delivery_app_flutter/state_management/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    // Simulate checking auth status
    await Future.delayed(const Duration(seconds: 2));
    // TODO: Implement your actual auth check logic here
    state = state.update(isLoggedIn: false, isLoading: false);
  }

  Future<void> signIn() async {
    state = state.update(isLoading: true);
    // TODO: Implement your sign in logic
    await Future.delayed(const Duration(seconds: 1));
    state = state.update(isLoggedIn: true, isLoading: false);
  }

  Future<void> signOut() async {
    state = state.update(isLoading: true);
    // TODO: Implement your sign out logic
    await Future.delayed(const Duration(seconds: 1));
    state = state.update(isLoggedIn: false, isLoading: false);
  }
}
