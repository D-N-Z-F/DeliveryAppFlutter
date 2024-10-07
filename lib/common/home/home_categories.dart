import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/screens/categories_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToCategories(Categories category) {
      final name = category.enumToString();
      context.pushNamed(
        CategoriesScreen.routeName,
        pathParameters: {'name': name},
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Header(heading: "Categories"),
          SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Categories.values.length,
              itemBuilder: (context, index) {
                final category = Categories.values[index];
                return GestureDetector(
                  onTap: () => navigateToCategories(category),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category.getIcon(),
                              color: Colors.white,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        category.enumToString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
