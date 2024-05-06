import 'package:firebase_database/firebase_database.dart';
import 'package:mealmatch/models/restaurant.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataManager with ChangeNotifier {
  static final DataManager _instance = DataManager._internal();
  factory DataManager() => _instance;

  // 프라이빗 생성자
  DataManager._internal();

  List<Restaurant?> restaurants = [];

  // 데이터베이스 리스너를 설정하는 별도의 메소드
  void initialize() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('restaurants');
    ref.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists && snapshot.value != null) {
        // Check if snapshot.value is a list before assigning it
        if (snapshot.value is List<dynamic>) {
          List<dynamic> dataList = snapshot.value as List<dynamic>;
          restaurants = dataList.map((x) {
            if (x is Map<dynamic, dynamic>) {
              return Restaurant.fromJson(Map<String, dynamic>.from(x));
            }
            return null;
          }).where((x) => x != null).toList(); // Filter out nulls if any casting fails
          notifyListeners();
        } else {
          print('Data is not in the expected format (List<dynamic>)');
        }
      }
    });
  }

}




// class DataManager {
//   static final DataManager _instance = DataManager._internal();
//   factory DataManager() => _instance;
//   DataManager._internal();
//
//   Map<dynamic, dynamic> restaurantsData = {};
//
//   Future<void> loadInitialData() async {
//     final DatabaseReference ref = FirebaseDatabase.instance.ref();
//     final snapshot = await ref.child('restaurants').get();
//     if (snapshot.exists) {
//       // print(snapshot.value);
//       for (int i = 0; i < 3; i++) {
//         print(snapshot.child('$i/address').value.toString());
//         print(snapshot.child('$i/category').value.toString());
//         print(snapshot.child('$i/tel').value.toString());
//       }
//       // print(snapshot.child('address').value.toString());
//       // print(snapshot.child('category').value.toString());
//       // print(snapshot.child('opening_hours').value.toString());
//     } else {
//       print('No data available.');
//     }
//   }
// }
