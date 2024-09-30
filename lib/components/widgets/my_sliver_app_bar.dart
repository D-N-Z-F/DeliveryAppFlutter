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
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTap: () {
                    _navigateToSearch();
                  },
                )),
          ],
        ),
      )),
    );
  }
}
