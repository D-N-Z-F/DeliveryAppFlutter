import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/data/providers/address_provider.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressCard extends ConsumerWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final data = ref.watch(addressProvider);
    return Card(
      color: scheme.get(MainColors.secondary),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.lg),
        child: Row(
          children: [
            const Icon(Icons.delivery_dining_outlined, size: Sizes.xl),
            const SizedBox(width: Sizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Delivery Address:"),
                data.when(
                  data: (address) => Text("$address"),
                  error: (_, __) => const EmptyDisplay(
                    message: Strings.defaultErrorMessage,
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
