import 'package:delivery_app_flutter/data/models/item.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Item item;
  const FoodTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(item.title),
                      Text(item.desc),
                      Text(item.price.toString())
                    ])),
                Image.asset(
                  Strings.defaultRestaurantImagePath,
                  height: 120,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
