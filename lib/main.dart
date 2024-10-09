import 'package:delivery_app_flutter/data/providers/router_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/data/services/notification_service.dart';
import 'package:delivery_app_flutter/data/services/stripe_service.dart';
import 'package:delivery_app_flutter/firebase_options.dart';
import 'package:delivery_app_flutter/data/providers/theme_provider.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      theme: themeData,
      darkTheme: themeData,
      routerConfig: router,
    );
  }
}
