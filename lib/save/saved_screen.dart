import 'package:flutter/material.dart';
import 'package:mealmatch/save/widgets/save_list_item.dart';
import 'package:mealmatch/save/widgets/saved_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:mealmatch/save/add_list_screen.dart';
import 'package:mealmatch/models/bookmark_list.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

    // 디폴트 북마크 리스트를 분리
    final defaultBookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == 'My Place');
    final otherBookmarkLists = dataManager.bookmarkLists.where((list) => list.name != 'My Place').toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Lists',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddListPage()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 28, color: Colors.green),
                    const SizedBox(width: 5),
                    const Text(
                      "New list",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Display Default Bookmark List
                SaveListItem(
                  title: defaultBookmarkList.name,
                  subtitle: defaultBookmarkList.description ?? '',
                  icon: Icons.bookmark,
                  iconColor: _getColor(defaultBookmarkList.color),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarkDetailPage(bookmarkList: defaultBookmarkList),
                      ),
                    );
                  },
                  onEdit: null,
                  onDelete: null,
                ),
                // Display Other Bookmark Lists
                ...otherBookmarkLists.map((bookmarkList) {
                  return SaveListItem(
                    title: bookmarkList.name,
                    subtitle: bookmarkList.description ?? '',
                    icon: Icons.bookmark,
                    iconColor: _getColor(bookmarkList.color),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookmarkDetailPage(bookmarkList: bookmarkList),
                        ),
                      );
                    },
                    onEdit: () => _editBookmarkList(context, bookmarkList),
                    onDelete: () => _showDeleteConfirmationDialog(context, bookmarkList),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
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

  void _showDeleteConfirmationDialog(BuildContext context, BookmarkList bookmarkList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Deleting a list will also remove the saved places in it."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<DataManager>(context, listen: false).removeBookmarkList(bookmarkList);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editBookmarkList(BuildContext context, BookmarkList bookmarkList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddListPage(
          initialData: bookmarkList,
          onSave: (updatedList) {
            Provider.of<DataManager>(context, listen: false).updateBookmarkList(bookmarkList, updatedList);
          },
        ),
      ),
    );
  }
}
