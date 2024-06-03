import 'package:flutter/material.dart';
import 'package:mealmatch/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';

class EditRestaurantDialog extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onSave;

  const EditRestaurantDialog({Key? key, required this.restaurant, required this.onSave}) : super(key: key);

  @override
  _EditRestaurantDialogState createState() => _EditRestaurantDialogState();
}

class _EditRestaurantDialogState extends State<EditRestaurantDialog> {
  Map<String, bool> checkedLists = {};

  @override
  void initState() {
    super.initState();
    final dataManager = Provider.of<DataManager>(context, listen: false);
    dataManager.bookmarkLists.forEach((bookmarkList) {
      checkedLists[bookmarkList.name] = bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

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
            widget.onSave();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void _saveBookmarkChanges(DataManager dataManager) {
    final List<String> listsToRemove = [];
    checkedLists.forEach((listName, isChecked) {
      final bookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == listName);
      if (isChecked) {
        if (!bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.addRestaurantToBookmarkList(widget.restaurant, bookmarkList);
        }
      } else {
        if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.removeRestaurantFromBookmarkList(widget.restaurant, bookmarkList);
          listsToRemove.add(listName);
        }
      }
    });
    // Remove restaurants from UI state
    listsToRemove.forEach((listName) {
      final bookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == listName);
      bookmarkList.restaurants.removeWhere((r) => r.enName == widget.restaurant.enName);
    });
  }
}
