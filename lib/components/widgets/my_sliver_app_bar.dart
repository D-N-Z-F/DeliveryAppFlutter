import 'package:delivery_app_flutter/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void _navigateToSearch() {
      context.push(SearchScreen.route);
    }

    return SliverAppBar(
      expandedHeight: 200,
      collapsedHeight: 160,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        color: Colors.blue,
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
              child: SearchBar(
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16)),
                hintText: "Search...",
                onTap: () {
                  _navigateToSearch();
                },
                leading: const Icon(Icons.search),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
