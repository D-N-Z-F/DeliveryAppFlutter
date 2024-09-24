import 'dart:io';

import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) =>
      View.of(context).viewInsets.bottom == 0;

  static bool isPortraitOrientation(BuildContext context) =>
      View.of(context).viewInsets.bottom != 0;

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  static double getDimensions(BuildContext context, DimensionType type) {
    final mq = MediaQuery.of(context);
    return switch (type) {
      DimensionType.screenHeight => mq.size.height,
      DimensionType.screenWidth => mq.size.width,
      DimensionType.pixelRatio => mq.devicePixelRatio,
      DimensionType.statusBarHeight => mq.padding.top,
      DimensionType.bottomNavigationBarHeight => kBottomNavigationBarHeight,
      DimensionType.appBarHeight => kToolbarHeight,
      DimensionType.keyboardHeight => View.of(context).viewInsets.bottom
    };
  }

  static bool isKeyboardVisible(BuildContext context) =>
      View.of(context).viewInsets.bottom > 0;

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isMobileDevice() =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  static bool isiOS() => Platform.isIOS;

  static bool isAndroid() => Platform.isAndroid;

  // static void launchUrl(String, url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw "Couldn't launch $url";
  //   }
  // }
}
