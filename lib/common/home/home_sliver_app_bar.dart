import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSearch() {
      context.push(SearchScreen.route);
    }

    void addAddressBox() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Add address"),
                content: const TextField(
                    decoration: InputDecoration(hintText: "Add address...")),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Save")),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"))
                    ],
                  )
                ],
              ));
    }

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
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8.0),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Sizes.font["xs"],
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
                      Text(
                        Helpers.truncateText("35, Taman Haha, Jalan Hehe", 21),
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
