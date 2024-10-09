import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/data/providers/cart_provider.dart';
import 'package:delivery_app_flutter/data/services/stripe_service.dart';
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
            builder: (_, ref, __) => ElevatedButton(
              onPressed: () async {
                await StripeService().makePayment(
                  _getTotal(_getSubtotal()),
                  Strings.defaultCurrency,
                );
                ref.invalidate(cartProvider);
                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.sm),
                ),
              ),
              child: const Text("Pay Now"),
            ),
          ),
        ],
      );
}
