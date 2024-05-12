
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mealmatch/bottom_navbar/widgets/bottom_navbar_item.dart';
import 'package:mealmatch/screen/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  int currentIndex;
  final Function(int) onTap;

  BottomNavbar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  void updateIndex(int index){
    setState(() {
      widget.currentIndex = index;
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: List.generate(3,
              (int index) => BottomNavbarItem(
          label: _bottomNavigationBarLabels[index],
          icon: _bottomNavigationBarIcons[index],
          isSelected: widget.currentIndex == index,
          onTap: () => updateIndex(index),
        ),
        )
      ),
    );
  }
}

final List<String> _bottomNavigationBarLabels = [
  "Nearby",
  "Saved",
  "My",
];

final List<IconData> _bottomNavigationBarIcons = [
  Icons.location_on,
  Icons.bookmark_border,
  Icons.person_pin_outlined,
];