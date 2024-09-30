import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EmptyDisplay extends StatelessWidget {
  const EmptyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info,
          color: Colors.grey,
          size: Sizes.icon["xxl"],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: const Text("No data to show."),
        )
      ],
    );
  }
}
