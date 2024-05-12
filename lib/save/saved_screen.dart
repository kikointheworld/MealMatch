import 'package:flutter/material.dart';
import 'package:mealmatch/global/widgets/search_widget.dart';
import 'package:mealmatch/save/widgets/save_bottom_item.dart';
import 'package:mealmatch/save/widgets/save_list_item.dart';
import 'package:mealmatch/config/palette.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const Text("Your Lists", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                Row(
                  children: [
                    Icon(Icons.add, size: 22, color: Colors.blue[800]),
                    const SizedBox(width: 10,),
                    Text("New list", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.blue[800]),),
                  ],
                )
              ],
            ),
          ),

          SaveListItem(
            title: "Favorites",
            subtitle: "Private - 1 place",
            onTap: () {},
            icon: Icons.favorite_outline,
            iconColor: Colors.pinkAccent,
            onMenuTapListener: () {},
          ),
          const SizedBox(height: 10,),

          SaveListItem(
            title: "Want to go",
            subtitle: "Private - 0 place",
            icon: Icons.outlined_flag,
            iconColor: Colors.green,
            onTap: () {},
            onMenuTapListener: () {},
          ),
          const SizedBox(height: 10,),

          SaveListItem(
            title: "Starred places",
            subtitle: "Private - 0 place",
            icon: Icons.star_border,
            iconColor: Colors.deepOrangeAccent,
            onTap: () {},
            onMenuTapListener: () {},
          ),
          const SizedBox(height: 10,),

          SaveListItem(
            title: "Labeled",
            subtitle: "Private - 0 place",
            icon: Icons.label_important_outline,
            iconColor: Colors.blue,
            onTap: () {},
            onMenuTapListener: () {},
          ),
          const SizedBox(height: 10,),

          /*SaveListItem(
            title: "Travel plans",
            subtitle: "Private - 0 place",
            icon: Icons.backpack_outlined,
            iconColor: Colors.blue,
            onTap: () {},
            onMenuTapListener: () {},
          ),
          const SizedBox(height: 25,),*/

          /*const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SaveBottomItem(
                icon: Icons.timeline,
                title: "Timeline",
              ),
              SaveBottomItem(
                icon: Icons.arrow_circle_right_outlined,
                title: "Following",
              ),
              SaveBottomItem(
                icon: Icons.map_outlined,
                title: "Maps",
              ),
            ],
          ),*/
        ]
      ),
    );
  }
}
