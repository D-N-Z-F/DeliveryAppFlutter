import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String heading;
  final bool omitMargin;
  final Color? color;
  const Header({
    super.key,
    required this.heading,
    this.omitMargin = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: omitMargin ? null : const EdgeInsets.all(Sizes.sm),
        child: Text(
          heading,
          style: TextStyle(
            fontSize: Sizes.fontMd,
            letterSpacing: Sizes.letterSpacing,
            color: color ?? Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      );
}
