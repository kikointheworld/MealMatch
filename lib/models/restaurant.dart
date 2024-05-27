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
  final List<String>? mainImages;
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
    this.mainImages,
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
        mainImages: json["main_images"] != null ? List<String>.from(json["main_images"]) : null,
      latitude: json["address"]["lat"],
      longitude: json["address"]["lng"],
      menus: json['menus'] != null ? (json['menus'] as List).map((x) =>
          Menu.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) =>
          Review.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      tel: json.containsKey("tel") ? json["tel"] : null
    );
  }
}

