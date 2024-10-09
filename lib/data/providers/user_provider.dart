import 'package:delivery_app_flutter/data/models/user.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider = Provider((ref) => UserRepo());

final userProvider = FutureProvider<User?>(
  (ref) => ref.watch(repoProvider).getUserById(),
);
