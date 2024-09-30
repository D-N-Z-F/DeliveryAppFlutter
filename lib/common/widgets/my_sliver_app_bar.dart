import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SearchAnchor(
            builder: (context, controller) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                      hintText: 'Search...',
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (value) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    ),
                  ],
                ),
              );
            },
            suggestionsBuilder: (context, controller) {
              return [
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Suggestion 1'),
                  onTap: () {
                    // Handle suggestion tap
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Suggestion 2'),
                  onTap: () {
                    // Handle suggestion tap
                  },
                ),
              ]; // Return a list of widgets here
            },
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.blueAccent,
          // child: PreferredSize(
          //   preferredSize:
          //       const Size.fromHeight(50), // Height of the search bar
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Search...',
          //         prefixIcon: const Icon(Icons.search),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide.none,
          //         ),
          //         filled: true,
          //         fillColor: Colors.white,
          //       ),
          //     ),
          //   ),
          // ), // Customize your background if needed
        ),
      ),
    );
  }
}
