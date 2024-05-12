import 'package:flutter/material.dart';
import 'package:mealmatch/global/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchWidget(
            autoFocus: true,
            isOutlined: false,
            isOnSearchPage: true,
            onCancelTap: () {
              _searchController.clear();
            },
            controller: _searchController,
            onSubmitted: (value) {},
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
