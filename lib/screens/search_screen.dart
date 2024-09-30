import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const route = "/search";
  static const routeName = "Search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 340, // Adjust width to fit your design
              child: SearchBar(
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10.0)),
                hintText: "Search...",
                onTap: () {},
                leading: const Icon(Icons.search),
              ),
            ),
          ),
          )
          
        ],
      ),
      body: const Center(child: Text("Search Screen")),
    );
  }
}
