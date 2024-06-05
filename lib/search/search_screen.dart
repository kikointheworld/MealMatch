import 'package:flutter/material.dart';
import 'package:mealmatch/global/widgets/search_widget.dart';
import 'package:mealmatch/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:mealmatch/global/restaurant_detail_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> searchResults = [];

  void _search(String query) async {
    final dataManager = Provider.of<DataManager>(context, listen: false);
    List<Restaurant> results = await dataManager.searchRestaurants(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for restaurants...',
            border: InputBorder.none,
          ),
          onChanged: _search,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              setState(() {
                searchResults = [];
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final restaurant = searchResults[index];
          return ListTile(
            title: Text(restaurant.enName),
            subtitle: Text(restaurant.enCategory),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
