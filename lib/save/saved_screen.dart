import 'package:flutter/material.dart';
import 'package:mealmatch/global/widgets/search_widget.dart';
import 'package:mealmatch/save/widgets/save_list_item.dart';
import 'package:provider/provider.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:mealmatch/save/add_list_screen.dart'; // 새로운 페이지 import

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
    // Accessing DataManager instance
    final dataManager = Provider.of<DataManager>(context);

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
                const Text("Your Lists",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddListPage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 22, color: Colors.blue[800]),
                      const SizedBox(width: 10),
                      Text("New list",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue[800])),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...dataManager.bookmarkLists.map((bookmarkList) {
            return SaveListItem(
              title: bookmarkList.name,
              subtitle: bookmarkList.description ?? '',
              icon: Icons.restaurant_menu,
              iconColor: _getColor(bookmarkList.color),
              onTap: () {},
              onMenuTapListener: () {},
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddListPage(
                      isEdit: true,
                      bookmarkList: bookmarkList,
                    ),
                  ),
                );
              },
              onDelete: () {
                dataManager.removeBookmarkList(bookmarkList);
              },
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
}
