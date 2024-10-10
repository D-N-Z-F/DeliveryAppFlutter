import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/providers/loading_provider.dart';
import 'package:delivery_app_flutter/data/services/notification_service.dart';
import 'package:delivery_app_flutter/data/services/stripe_service.dart';
import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

class PriceSummary extends ConsumerWidget {
  final Map<Item, int> items;
  final double tax = 5.0;
  final double deliveryFee = 5.0;

  const PriceSummary({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final isLoading = ref.watch(loadingProvider);
    double getSubtotal() => items.entries
        .map(
          (entry) => entry.key.price * entry.value,
        ) // Calculate price * quantity for each item
        .reduce((a, b) => a + b);

    double getTotal(double subtotal) =>
        subtotal + (tax / 100 * subtotal) + deliveryFee;

    void showDeliveryProcess() {
      Workmanager().registerOneOffTask(
        "taskProcessing",
        "Processing Order",
        initialDelay: const Duration(seconds: 5),
        inputData: {"status": DeliveryStatus.processing.enumToString()},
      );
      Workmanager().registerOneOffTask(
        "taskPreparing",
        "Preparing Food",
        initialDelay: const Duration(seconds: 10),
        inputData: {"status": DeliveryStatus.preparing.enumToString()},
      );
      Workmanager().registerOneOffTask(
        "taskEnRoute",
        "Delivery En Route",
        initialDelay: const Duration(seconds: 15),
        inputData: {"status": DeliveryStatus.enroute.enumToString()},
      );
      Workmanager().registerOneOffTask(
        "taskDelivered",
        "Food Delivered",
        initialDelay: const Duration(seconds: 20),
        inputData: {"status": DeliveryStatus.delivered.enumToString()},
      );
    }

    Future<void> performTransaction() async {
      final stripe = StripeService();
      ref.read(loadingProvider.notifier).startLoading();
      final status = await stripe.makePayment(
        getTotal(getSubtotal()),
        Strings.defaultCurrency,
        context,
      );
      ref.read(loadingProvider.notifier).stopLoading();
      if (status != null && status.containsKey(PaymentStatus.isConfirmed)) {
        MyApp.showSnackBar(
          content: "Payment success.",
          theme: SnackBarTheme.success,
          color: MyColors.success,
          seconds: 2,
        );
        NotificationService.showNotification(
          "Transaction Success!",
          "Your order of \$${getTotal(getSubtotal()).toStringAsFixed(2)} was successful.",
        );
        showDeliveryProcess();
        await stripe.generateOrderDetails(status[PaymentStatus.isConfirmed]!);
        ref.invalidate(cartProvider);
        if (context.mounted) Navigator.pop(context);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal:', style: TextStyle(fontSize: 16)),
            Text(
              '\$${getSubtotal().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tax:', style: TextStyle(fontSize: 16)),
            Text(
              '${tax.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery Fees:', style: TextStyle(fontSize: 16)),
            Text(
              '\$${deliveryFee.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const Divider(
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${getTotal(getSubtotal()).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(
          height: Sizes.dividerHeight,
          thickness: Sizes.dividerThickness,
        ),
        ElevatedButton(
          onPressed: isLoading ? null : performTransaction,
          style: ElevatedButton.styleFrom(
            backgroundColor: scheme.get(MainColors.secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.sm),
            ),
          ),
          child: isLoading
              ? const LoadingIndicator()
              : Text(
                  "Pay Now",
                  style:
                      TextStyle(color: scheme.get(MainColors.inversePrimary)),
                ),
        ),
      ],
    );
  }
}
