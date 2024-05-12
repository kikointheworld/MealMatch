import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmatch/bottom_navbar/bottom_navbar.dart';
import '../save/saved_screen.dart';
import '../my/my_screen.dart';
import '../nearby/nearby_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _controller = AnimationController(vsync: this);
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _switchPageOnIndex(currentIndex),
        bottomNavigationBar: BottomNavbar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          }
        ),
    );
  }

  _switchPageOnIndex(int index){
    switch(index){
      case 0:{
        return const NearbyPage(currentIndex: 0,);
      }
      case 1:{
        return const SavedPage();
      }
      case 2:{
        return const MyPage();
      }
    }
  }
}

