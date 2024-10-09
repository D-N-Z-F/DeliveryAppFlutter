import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressProvider = FutureProvider(
  (ref) => ref.watch(hiveProvider).getAddressFromBox(),
);
