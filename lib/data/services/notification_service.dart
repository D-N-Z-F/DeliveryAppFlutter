import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: onReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onReceiveNotification,
    );
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotification(String title, String body) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        Strings.channelId,
        Strings.channelName,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await plugin.show((title + body).length, title, body, notificationDetails);
  }

  static Future<void> scheduleNotification(
    String title,
    String body,
    DateTime? scheduledDate,
  ) async {
    scheduledDate ??= DateTime.now().add(const Duration(seconds: 2));
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        Strings.channelId,
        Strings.channelName,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await plugin.zonedSchedule(
      (title + body).length,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static Future<void> onReceiveNotification(
    NotificationResponse response,
  ) async {
    debugPrint(response.payload);
  }
}
