import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: CachedNetworkImage(
                imageUrl: restaurant.imageUrl,
                placeholder: (context, url) => Image.asset(
                  Strings.defaultRestaurantImagePath,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  Strings.defaultRestaurantImagePath,
                  height: 150,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Helpers.truncateText(restaurant.title, 21),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.font["md"]),
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.rating.clamp(0.0, 5.0).toStringAsFixed(2),
                        ),
                        const SizedBox(width: Sizes.xs),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: Sizes.icon["sm"],
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  restaurant.category.name,
                  style: TextStyle(fontSize: Sizes.font["xs"]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
