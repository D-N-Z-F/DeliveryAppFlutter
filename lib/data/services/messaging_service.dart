import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFCM() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Message received: ${message.notification}');
    });

    // Background/Terminated
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<String?> getFCMToken() async => await _firebaseMessaging.getToken();

  Future<void> _backgroundMessageHandler(
    RemoteMessage message,
  ) async {
    debugPrint('Message handled in the background: ${message.notification}');
  }
}
