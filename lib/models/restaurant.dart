import 'package:mealmatch/models/menu.dart';
import 'package:mealmatch/models/review.dart';

class Restaurant {
  final String enName;
  final String enAddress;
  final String enCategory;
  final String enOpeningHours;
  final String koName;
  final String koAddress;
  final String koCategory;
  final String koOpeningHours;
  final double latitude;
  final double longitude;
  final List<Menu> menus;
  final List<Review> reviews;
  final String? tel;

  Restaurant({
    required this.enName,
    required this.enAddress,
    required this.enCategory,
    required this.enOpeningHours,
    required this.koName,
    required this.koAddress,
    required this.koCategory,
    required this.koOpeningHours,
    required this.latitude,
    required this.longitude,
    required this.menus,
    required this.reviews,
    this.tel,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      enName: json["name"]["enName"],
      enAddress: json["address"]["enAddress"],
      enCategory: json["category"]["enCategory"],
      enOpeningHours: json["opening_hours"]["en"],
      koName: json["name"]["koName"],
      koAddress: json["address"]["koAddress"],
      koCategory: json["category"]["koCategory"],
      koOpeningHours: json["opening_hours"]["ko"],
      latitude: json["address"]["lat"],
      longitude: json["address"]["lng"],
      menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      // menus: Menu.fromList(json['menus'] as List),
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      tel: json.containsKey("tel") ? json["tel"] : null
    );
  }
}



// class Restaurant {
//   final String enName;
//   final String enAddress;
//   final String enCategory;
//   final String enOpeningHours;
//   final String koName;
//   final String koAddress;
//   final String koCategory;
//   final String koOpeningHours;
//   final double latitude;
//   final double longitude;
//   // final List<String> mainImages;
//   final List<Menu> menus;
//   final List<Review> reviews;
//   final String tel;
//
//   Restaurant({
//     required this.enName,
//     required this.enAddress,
//     required this.enCategory,
//     required this.enOpeningHours,
//     required this.koName,
//     required this.koAddress,
//     required this.koCategory,
//     required this.koOpeningHours,
//     required this.latitude,
//     required this.longitude,
//     // required this.mainImages,
//     required this.menus,
//     required this.reviews,
//     required this.tel
//   });
//
//   factory Restaurant.fromJson(Map<String, dynamic> json) {
//     return Restaurant(
//       enName: json["name"]["enName"],
//       enAddress: json["address"]["enAddress"],
//       enCategory: json["category"]["enCategory"],
//       enOpeningHours: json["opening_hours"]["en"],
//       koName: json["name"]["koName"],
//       koAddress: json["address"]["koAddress"],
//       koCategory: json["category"]["koCategory"],
//       koOpeningHours: json["opening_hours"]["ko"],
//       latitude: json["address"]["lat"],
//       longitude: json["address"]["lng"],
//       // mainImages: List<String>.from(json['main_images'] ?? []),
//       menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromJson(x as Map<String, dynamic>)).toList() : [],
//       reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromJson(x as Map<String, dynamic>)).toList() : [],
//       tel: json["tel"]
//     );
//   }
// }


// class Restaurant {
//   final String name;
//   final String address;
//   final String category;
//   final List<String> mainImages;
//   final List<Menu> menus;
//   final String openingHours;
//   final List<Review> reviews;
//
//   Restaurant({
//     required this.name,
//     required this.address,
//     required this.category,
//     required this.mainImages,
//     required this.menus,
//     required this.openingHours,
//     required this.reviews,
//   });
//
//   factory Restaurant.fromJson(Map<String, dynamic> json) {
//     return Restaurant(
//       name: json['name'],
//       address: json['address'],
//       category: json['category'],
//       mainImages: List<String>.from(json['main_images'] ?? []),
//       menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromList(x as List<dynamic>)).toList() : [],
//       openingHours: json['opening_hours'],
//       reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromList(x as List<dynamic>)).toList() : [],
//     );
//   }
// }
