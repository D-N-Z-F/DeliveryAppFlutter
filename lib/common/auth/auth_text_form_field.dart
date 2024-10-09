import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthTextFormField extends ConsumerWidget {
  final TextEditingController controller;
  final Function(String?)? validator;
  final Function(String?, String?)? validator2;
  final String? labelText;
  final String? hintText;
  final bool isPasswordField;
  final String? comparator;

  const AuthTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.validator2,
    this.labelText,
    this.hintText,
    this.isPasswordField = false,
    this.comparator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
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
            color: scheme.get(MainColors.inverseSurface).withOpacity(0.6),
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
          fillColor: scheme.get(MainColors.secondary),
        ),
      ),
    );
  }
}
