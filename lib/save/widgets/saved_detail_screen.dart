import 'package:flutter/material.dart';
import 'package:mealmatch/models/bookmark_list.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:mealmatch/models/restaurant.dart';
import 'edit_restaurant_dialog.dart';
import '../../global/restaurant_detail_screen.dart';

class BookmarkDetailPage extends StatefulWidget {
  final BookmarkList bookmarkList;

  const BookmarkDetailPage({Key? key, required this.bookmarkList}) : super(key: key);

  @override
  _BookmarkDetailPageState createState() => _BookmarkDetailPageState();
}

class _BookmarkDetailPageState extends State<BookmarkDetailPage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Icon(Icons.bookmark, color: _getColor(widget.bookmarkList.color), size: 40),
                const SizedBox(height: 8),
                Text(
                  widget.bookmarkList.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.bookmarkList.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = widget.bookmarkList.restaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant.enName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      restaurant.enCategory,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      restaurant.enAddress,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditRestaurantDialog(context, restaurant);
                                  } else if (value == 'delete') {
                                    _showDeleteConfirmationDialog(context, restaurant);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return const [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ];
                                },
                                child: const Icon(Icons.more_vert, size: 28),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (restaurant.mainImages != null && restaurant.mainImages!.isNotEmpty)
                            Row(
                              children: restaurant.mainImages!
                                  .take(3)
                                  .map(
                                    (image) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
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

  void _showEditRestaurantDialog(BuildContext context, Restaurant restaurant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditRestaurantDialog(
          restaurant: restaurant,
          onSave: () {
            _refresh();
          },
        );
      },
    ).then((_) => setState(() {}));
  }

  void _showDeleteConfirmationDialog(BuildContext context, Restaurant restaurant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this restaurant from the list?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final dataManager = Provider.of<DataManager>(context, listen: false);
                dataManager.removeRestaurantFromBookmarkList(restaurant, widget.bookmarkList);
                setState(() {
                  widget.bookmarkList.restaurants.removeWhere((r) => r.enName == restaurant.enName);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'lime':
        return Colors.limeAccent[700]!;
      case 'blue':
        return Colors.blue;
      case 'cyan':
        return Colors.cyan;
      case 'pink2':
        return Colors.pink[200]!;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'indigo':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}
