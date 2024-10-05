import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class RestaurantPageSliverAppBar extends StatelessWidget {
  final Widget title;
  final Restaurant restaurant;
  const RestaurantPageSliverAppBar(
      {super.key, required this.restaurant, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 340,
      collapsedHeight: Sizes.appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          expandedTitleScale: 1.0,
          background: ClipRRect(
            child: Stack(
              children: [
                CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: restaurant.imageUrl,
                  placeholder: (context, url) => Image.asset(
                    Strings.defaultRestaurantImagePath,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Strings.defaultRestaurantImagePath,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.black
                      .withOpacity(0.5), // Change color and opacity here
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.rating
                                  .clamp(0.0, 5.0)
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(width: Sizes.xs),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: Sizes.icon["md"],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: title),
    );
  }
}

// Container(
//           margin: const EdgeInsets.only(left: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize
//                 .min, // Ensures the column doesn't take up unnecessary space
//             crossAxisAlignment:
//                 CrossAxisAlignment.start, // Align title and rating to the left
//             children: [
//               // Restaurant title
//               Text(
//                 restaurant.title,
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               const SizedBox(
//                   height: 5), // Add some spacing between title and rating
//               // Rating row
//               Row(
//                 children: [
//                   Text(
//                     restaurant.rating.clamp(0.0, 5.0).toStringAsFixed(2),
//                     style: const TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   const SizedBox(width: Sizes.xs),
//                   Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                     size: Sizes.icon["sm"],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
