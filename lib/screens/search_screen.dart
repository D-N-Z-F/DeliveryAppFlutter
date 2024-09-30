import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const route = "/search";
  static const routeName = "Search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> recentSearches = [
    "Flutter",
    "Dart",
    "State Management",
    "Riverpod",
    "Firebase",
    "Provider",
    "Animation",
    "Kotlin",
    "Android Studio",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 40,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
              onChanged: (query) {
                // Add your search logic h ere
                print("Searching for: $query");
              },
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recent Searches",  style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                      itemCount: recentSearches.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.history),
                          title: Text(recentSearches[index]),
                          onTap: () {
                            // Handle search item tap
                            print("Selected: ${recentSearches[index]}");
                          },
                        );
                      }))
            ],
          ),
        ));
  }
}
