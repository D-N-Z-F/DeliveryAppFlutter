import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/services/stripe_service.dart';
import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/utils/constants/colors.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceSummary extends StatelessWidget {
  final Map<Item, int> items;
  final double tax = 5.0;
  final double deliveryFee = 5.0;

  const PriceSummary({super.key, required this.items});

  double _getSubtotal() => items.entries
      .map((entry) =>
          entry.key.price *
          entry.value) // Calculate price * quantity for each item
      .reduce((a, b) => a + b);

  double _getTotal(double subtotal) =>
      subtotal + (tax / 100 * subtotal) + deliveryFee;

  Future<void> _performTransaction(BuildContext context, WidgetRef ref) async {
    final stripe = StripeService();
    final status = await stripe.makePayment(
      _getTotal(_getSubtotal()),
      Strings.defaultCurrency,
      context,
    );
    if (status != null && status.containsKey(PaymentStatus.isConfirmed)) {
      MyApp.showSnackBar(
        content: "Payment success.",
        theme: SnackBarTheme.success,
        color: MyColors.success,
        seconds: 2,
      );
      await stripe.generateOrderDetails(status[PaymentStatus.isConfirmed]!);
      ref.invalidate(cartProvider);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
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
                '\$${_getSubtotal().toStringAsFixed(2)}',
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
                '\$${_getTotal(_getSubtotal()).toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: Sizes.dividerHeight,
            thickness: Sizes.dividerThickness,
          ),
          Consumer(
            builder: (context, ref, __) => ElevatedButton(
              onPressed: () async => _performTransaction(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.sm),
                ),
              ),
              child: Text(
                "Pay Now",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      );
}
