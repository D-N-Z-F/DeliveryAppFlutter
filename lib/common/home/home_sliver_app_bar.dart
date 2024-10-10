import 'package:delivery_app_flutter/common/auth/auth_text_form_field.dart';
import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/data/providers/address_provider.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:delivery_app_flutter/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeSliverAppBar extends ConsumerWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final formKey = GlobalKey<FormState>();
    final data = ref.watch(addressProvider);
    final addressController = TextEditingController();
    void navigateToSearch() => context.push(SearchScreen.route);
    void updateAddress() async {
      if (formKey.currentState!.validate()) {
        await HiveService().updateAddressInBox(addressController.text);
        ref.invalidate(addressProvider);
        if (context.mounted) Navigator.pop(context);
      }
    }

    void addAddressBox() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Header(heading: 'Set Address', omitMargin: true),
            content: Form(
              key: formKey,
              child: AuthTextFormField(
                controller: addressController,
                labelText: "Enter your address",
                hintText: "e.g Taman Haha, Jalan Hehe, Unit-123",
                validator: Validators.validateAddress,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: updateAddress,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: scheme.get(MainColors.secondary),
                    ),
                    child: const Text("Save"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: scheme.get(MainColors.secondary),
                    ),
                    child: const Text("Cancel"),
                  )
                ],
              )
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.cardRadiusSm),
              ),
            ),
          ),
        );

    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 120,
      collapsedHeight: Sizes.appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        centerTitle: true,
        title: GestureDetector(
          onTap: navigateToSearch,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: scheme.get(MainColors.secondary).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: scheme.get(MainColors.primary)),
                const SizedBox(width: 8.0),
                Text(
                  'Search',
                  style: TextStyle(
                    color: scheme.get(MainColors.primary),
                    fontSize: Sizes.fontXs,
                  ),
                ),
              ],
            ),
          ),
        ),
        background: Container(
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Home"),
                GestureDetector(
                  onTap: () => addAddressBox(),
                  child: Row(
                    children: [
                      data.when(
                        data: (address) => Text(
                          Helpers.truncateText(address!, 21),
                        ),
                        error: (_, __) => const EmptyDisplay(
                          message: Strings.defaultErrorMessage,
                        ),
                        loading: () => const Center(child: LoadingIndicator()),
                      ),
                      const Icon(Icons.location_on_outlined),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
