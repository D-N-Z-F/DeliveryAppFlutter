import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/data/models/restaurant.dart';
import 'package:delivery_app_flutter/data/providers/recents_provider.dart';
import 'package:delivery_app_flutter/data/repositories/restaurant_repo.dart';
import 'package:delivery_app_flutter/data/services/hive_service.dart';
import 'package:delivery_app_flutter/screens/restaurant_screen.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static const route = "/search";
  static const routeName = "Search";

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Restaurant> searchResults = [];
  final restaurantRepo = RestaurantRepo();
  final _searchController = TextEditingController();
  final queryProvider = StateProvider<String?>((ref) => null);

  void updateRecents(Restaurant restaurant) async {
    await ref.read(hiveProvider).updateRecentsInBox(restaurant);
    ref.invalidate(recentsProvider);
  }

  void navigateToRestaurant(String id) {
    context.pushNamed(RestaurantScreen.routeName, pathParameters: {"id": id});
  }

  @override
  Widget build(BuildContext context) {
    final recents = ref.watch(recentsProvider);
    final query = ref.watch(queryProvider);
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
            onChanged: (value) {
              ref.read(queryProvider.notifier).state = value;
            },
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: restaurantRepo.getAllRestaurants(
            query: query,
            isSearch: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) searchResults = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  query == null || query.isEmpty
                      ? "Recent Searches"
                      : "Searching for \"$query\"",
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: query == null || query.isEmpty
                      ? recents.when(
                          data: (data) {
                            data = data.reversed.toList();
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: const Icon(Icons.history),
                                trailing: const Icon(Icons.arrow_outward),
                                title: Text(data[index].title),
                                onTap: () =>
                                    navigateToRestaurant(data[index].id!),
                              ),
                            );
                          },
                          error: (error, __) => EmptyDisplay(
                            message: error.toString(),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : searchResults.isEmpty
                          ? const SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: EmptyDisplay(
                                message: Strings.searchDisplayMessage,
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: const Icon(Icons.storefront),
                                trailing: const Icon(Icons.arrow_outward),
                                title: Text(searchResults[index].title),
                                onTap: () {
                                  updateRecents(searchResults[index]);
                                  navigateToRestaurant(
                                    searchResults[index].id!,
                                  );
                                },
                              ),
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
