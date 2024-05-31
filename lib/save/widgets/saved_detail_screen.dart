import 'package:flutter/material.dart';
import 'package:mealmatch/models/bookmark_list.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:mealmatch/models/restaurant.dart';

import '../../global/restaurant_detail_screen.dart';
// import 'package:mealmatch/global/widgets/restaurant_detail_screen.dart';

class BookmarkDetailPage extends StatelessWidget {
  final BookmarkList bookmarkList;

  const BookmarkDetailPage({Key? key, required this.bookmarkList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmarkList.name),
      ),
      body: ListView.builder(
        itemCount: bookmarkList.restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = bookmarkList.restaurants[index];
          return ListTile(
            title: Text(restaurant.enName),
            subtitle: Text(restaurant.enAddress),
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
