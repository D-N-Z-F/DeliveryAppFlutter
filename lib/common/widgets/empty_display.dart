import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class EmptyDisplay extends StatelessWidget {
  final String message;
  const EmptyDisplay({super.key, this.message = Strings.defaultDisplayMessage});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Card(
        color: scheme.get(MainColors.secondary),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: scheme.get(MainColors.primary),
                size: Sizes.iconXxl,
              ),
              Container(
                margin: const EdgeInsets.only(top: Sizes.md),
                child: Text(
                  message,
                  style: TextStyle(color: scheme.get(MainColors.primary)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
