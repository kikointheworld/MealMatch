import 'package:flutter/material.dart';
import 'package:mealmatch/global/widgets/search_widget.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

    // 디폴트 북마크 리스트를 분리
    final defaultBookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == 'My Place');
    final otherBookmarkLists = dataManager.bookmarkLists.where((list) => list.name != 'My Place').toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          SearchWidget(
            controller: _searchController,
            isOutlined: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Your Lists", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddListPage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 22, color: Colors.green),
                      const SizedBox(width: 10),
                      const Text("New list", style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green)),
                    ],
                  ),
                )
              ],
            ),
          ),
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
          const SizedBox(height: 10),
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
