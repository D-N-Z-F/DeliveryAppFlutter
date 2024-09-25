import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<bool> {
  AuthProvider() : super(false);

  void signIn() => state = true;
  void signOut() => state = false;
}

final authProvider =
    StateNotifierProvider<AuthProvider, bool>((ref) => AuthProvider());
