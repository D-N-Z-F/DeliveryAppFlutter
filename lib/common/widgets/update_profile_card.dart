import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfileCard extends ConsumerWidget {
  final String fieldName;
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final Function(String?)? validator;
  final Function(String?, String?)? validator2;
  final bool isPasswordField;
  final String? comparator;

  const UpdateProfileCard({
    super.key,
    required this.fieldName,
    required this.labelText,
    this.hintText,
    required this.controller,
    this.validator,
    this.validator2,
    this.isPasswordField = false,
    this.comparator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.get(MainColors.secondary),
      elevation: Sizes.cardElevation,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fieldName),
            Padding(
              padding: const EdgeInsets.only(top: Sizes.md),
              child: TextFormField(
                controller: controller,
                validator: (value) => validator != null
                    ? validator!(value)
                    : validator2!(value, comparator),
                obscureText: isPasswordField,
                decoration: InputDecoration(
                    labelText: labelText,
                    labelStyle: TextStyle(
                      color: scheme.get(MainColors.primary),
                    ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: scheme
                          .get(MainColors.inverseSurface)
                          .withOpacity(0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.sm),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.sm),
                        borderSide: BorderSide(
                          color: scheme.get(MainColors.primary),
                          width: Sizes.textFieldBorderThickness,
                        )),
                    filled: true,
                    fillColor: scheme.get(MainColors.surface),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
            )
          ],
        ), // Instantiated TextFormField widget
      ),
    );
  }
}
