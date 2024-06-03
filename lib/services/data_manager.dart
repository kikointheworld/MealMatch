import 'package:firebase_database/firebase_database.dart';
import 'package:mealmatch/models/restaurant.dart';
import 'package:mealmatch/models/bookmark_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataManager with ChangeNotifier {
  static final DataManager _instance = DataManager._internal();
  factory DataManager() => _instance;

  DataManager._internal() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _initializeUser(user);
        _loadBookmarkLists(user);
      }
    });
  }

  List<Restaurant?> restaurants = [];
  List<BookmarkList> bookmarkLists = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  void initialize() {
    DatabaseReference ref = _dbRef.child('restaurants');
    ref.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists && snapshot.value != null) {
        if (snapshot.value is List<dynamic>) {
          List<dynamic> dataList = snapshot.value as List<dynamic>;
          restaurants = dataList.map((x) {
            if (x is Map<dynamic, dynamic>) {
              return Restaurant.fromJson(Map<String, dynamic>.from(x));
            }
            return null;
          }).where((x) => x != null).toList();
          notifyListeners();
        } else {
          print('Data is not in the expected format (List<dynamic>)');
        }
      }
    });
  }

  void _initializeUser(User user) async {
    String userId = user.uid;
    DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

    DataSnapshot snapshot = await userListsRef.get();
    bool hasDefaultList = false;

    if (snapshot.exists) {
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        hasDefaultList = data.values.any((value) => value['name'] == 'My Place');
      }
    }

    if (!hasDefaultList) {
      BookmarkList defaultList = BookmarkList(
        name: 'My Place',
        color: 'green',
        description: 'My Place',
        isPublic: true,
        restaurants: [],
      );
      await userListsRef.push().set(defaultList.toJson());
    }
  }

  void addBookmarkList(BookmarkList bookmarkList) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      if (bookmarkList.name == 'My Place') {
        return; // 기본 리스트는 추가할 수 없음
      }
      await _dbRef.child('users').child(userId).child('bookmarkLists').push().set(bookmarkList.toJson());
      _loadBookmarkLists(user);
    }
  }

  void updateBookmarkList(BookmarkList oldList, BookmarkList newList) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      if (oldList.name == 'My Place') {
        return; // 기본 리스트는 수정할 수 없음
      }
      DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

      DatabaseEvent event = await userListsRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['name'] == oldList.name && value['color'] == oldList.color) {
            await userListsRef.child(key).update(newList.toJson());
            _loadBookmarkLists(user);
          }
        });
      }
    }
  }

  void removeBookmarkList(BookmarkList bookmarkList) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      if (bookmarkList.name == 'My Place') {
        return; // 기본 리스트는 삭제할 수 없음
      }
      DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

      DatabaseEvent event = await userListsRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['name'] == bookmarkList.name && value['color'] == bookmarkList.color) {
            await userListsRef.child(key).remove();
            _loadBookmarkLists(user);
          }
        });
      }
    }
  }

  void _loadBookmarkLists(User user) async {
    String userId = user.uid;
    DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

    userListsRef.onValue.listen((event) {
      final listsData = event.snapshot.value as Map<dynamic, dynamic>?;
      if (listsData != null) {
        bookmarkLists = listsData.entries.map((entry) {
          final value = entry.value as Map<dynamic, dynamic>;
          return BookmarkList(
            name: value['name'],
            color: value['color'],
            description: value['description'],
            isPublic: value['isPublic'],
            restaurants: value['restaurants'] != null
                ? (value['restaurants'] as Map<dynamic, dynamic>).values.map((item) {
              if (item is Map<dynamic, dynamic>) {
                return Restaurant.fromJson(Map<String, dynamic>.from(item));
              } else {
                return null;
              }
            }).whereType<Restaurant>().toList()
                : [],
          );
        }).toList();
        notifyListeners();
      } else {
        bookmarkLists = [];
        notifyListeners();
      }
    });
  }

  void addRestaurantToBookmarkList(Restaurant restaurant, BookmarkList bookmarkList) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

      DatabaseEvent event = await userListsRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['name'] == bookmarkList.name && value['color'] == bookmarkList.color) {
            await userListsRef.child(key).child('restaurants').push().set(restaurant.toJson());
            bookmarkList.restaurants.add(restaurant);
            notifyListeners();
          }
        });
      }
    }
  }

  void removeRestaurantFromBookmarkList(Restaurant restaurant, BookmarkList bookmarkList) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DatabaseReference userListsRef = _dbRef.child('users').child(userId).child('bookmarkLists');

      DatabaseEvent event = await userListsRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['name'] == bookmarkList.name && value['color'] == bookmarkList.color) {
            final restaurantsRef = userListsRef.child(key).child('restaurants');
            final restaurantsSnapshot = await restaurantsRef.once();
            if (restaurantsSnapshot.snapshot.exists) {
              Map<dynamic, dynamic> restaurantsData = restaurantsSnapshot.snapshot.value as Map<dynamic, dynamic>;
              restaurantsData.forEach((restaurantKey, restaurantValue) async {
                if (Restaurant.fromJson(Map<String, dynamic>.from(restaurantValue)).enName == restaurant.enName) {
                  await restaurantsRef.child(restaurantKey).remove();
                  bookmarkList.restaurants.removeWhere((r) => r.enName == restaurant.enName);
                  notifyListeners();
                }
              });
            }
          }
        });
      }
    }
  }
}
