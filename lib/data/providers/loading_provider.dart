import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingProvider extends StateNotifier<bool> {
  LoadingProvider(super.state);

  void startLoading() => state = true;
  void stopLoading() => state = false;
}

final loadingProvider = StateNotifierProvider<LoadingProvider, bool>(
  (ref) => LoadingProvider(false),
);
