import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String heading;
  const Header({super.key, required this.heading});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(Sizes.sm),
        child: Text(
          heading,
          style: TextStyle(
            fontSize: Sizes.font["md"],
            letterSpacing: Sizes.letterSpacing,
          ),
        ),
      );
}
