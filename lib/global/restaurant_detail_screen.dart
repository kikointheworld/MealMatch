import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import 'package:provider/provider.dart';
import '../services/data_manager.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Map<String, bool> checkedLists = {};
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final dataManager = Provider.of<DataManager>(context, listen: false);
    dataManager.bookmarkLists.forEach((bookmarkList) {
      if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
        isFavorite = true;
      }
      checkedLists[bookmarkList.name] = bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.enName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.restaurant.enName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.restaurant.enAddress, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(widget.restaurant.enCategory, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(widget.restaurant.enOpeningHours, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () => _showBookmarkDialog(context, dataManager),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookmarkDialog(BuildContext context, DataManager dataManager) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.restaurant.enName),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...dataManager.bookmarkLists.map((bookmarkList) {
                    return CheckboxListTile(
                      title: Text(bookmarkList.name),
                      value: checkedLists[bookmarkList.name] ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          checkedLists[bookmarkList.name] = value!;
                        });
                      },
                    );
                  }).toList(),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveBookmarkChanges(dataManager);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveBookmarkChanges(DataManager dataManager) {
    bool wasFavorite = isFavorite;
    isFavorite = false;

    checkedLists.forEach((listName, isChecked) {
      final bookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == listName);
      if (isChecked) {
        if (!bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.addRestaurantToBookmarkList(widget.restaurant, bookmarkList);
        }
        isFavorite = true; // 북마크 리스트에 추가되었으면 favorite 상태로 설정
      } else {
        if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.removeRestaurantFromBookmarkList(widget.restaurant, bookmarkList);
        }
      }
    });

    if (wasFavorite != isFavorite) {
      setState(() {}); // favorite 상태가 변경되었으면 화면을 갱신
    }
  }
}
