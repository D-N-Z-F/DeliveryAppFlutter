import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static final StripeService _instance = StripeService._internal();
  factory StripeService() => _instance;
  StripeService._internal();

  static const baseUrl = "https://api.stripe.com/v1/payment_intents";

  Future<void> init() async {
    Stripe.publishableKey = dotenv.env["stripePublishableKey"] ?? "";
    await Stripe.instance.applySettings();
  }

  String _convertAmount(double amount) => (amount * 100).toInt().toString();

  Future<String?> _createPaymentIntent(double amount, String currency) async =>
      await Helpers.globalErrorHandler(() async {
        final Dio dio = Dio();
        Map<String, dynamic> data = {
          "amount": _convertAmount(amount),
          "currency": currency,
        };
        final options = Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${dotenv.env["stripeSecretKey"]}",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        );
        var response = await dio.post(baseUrl, data: data, options: options);
        if (response.data != null) {
          return response.data["client_secret"];
        }
        return "";
      });

  Future<void> makePayment(double amount, String currency) async {
    await Helpers.globalErrorHandler(() async {
      String? clientSecret = await _createPaymentIntent(amount, currency);
      if (clientSecret == null || clientSecret.isEmpty) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: Strings.appName,
        ),
      );
      await _processPayment();
    });
  }

  Future<void> _processPayment() async =>
      await Helpers.globalErrorHandler(() async {
        await Stripe.instance.presentPaymentSheet();
        await Stripe.instance.confirmPaymentSheetPayment();
      });
}
