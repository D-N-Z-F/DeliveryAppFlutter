import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/screens/categories_screen.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
          Container(
            height: 75,
            padding: const EdgeInsets.symmetric(vertical: Sizes.sm),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Categories.values.length,
              itemBuilder: (context, index) {
                final category = Categories.values[index];
                return GestureDetector(
                  onTap: () => navigateToCategories(category),
                  child: Card(
                    color: scheme.get(MainColors.secondary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category.getIcon(),
                            color: scheme.get(MainColors.primary),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: Sizes.xs),
                            child: Text(
                              category.enumToString(),
                              style: TextStyle(
                                fontSize: Sizes.fontXs,
                                color: scheme.get(MainColors.primary),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
