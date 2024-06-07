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
  final String? mainOpeningHours;
  final Map<String, bool> classifications;

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
    this.mainOpeningHours,
    required this.classifications,
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
      menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromJson(x as Map<dynamic, dynamic>)).toList() : [],
      tel: json.containsKey("tel") ? json["tel"] : null,
      mainOpeningHours: json["opening_hours"].containsKey("main") ? json["opening_hours"]["main"] : null,
      classifications: json['new_classification'] != null
          ? Map<String, bool>.from(json['new_classification'])
          : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": {
        "enName": enName,
        "koName": koName,
      },
      "address": {
        "enAddress": enAddress,
        "koAddress": koAddress,
        "lat": latitude,
        "lng": longitude,
      },
      "category": {
        "enCategory": enCategory,
        "koCategory": koCategory,
      },
      "opening_hours": {
        "en": enOpeningHours,
        "ko": koOpeningHours,
        "main": mainOpeningHours,
      },
      "main_images": mainImages,
      "menus": menus.map((menu) => menu.toJson()).toList(),
      "reviews": reviews.map((review) => review.toJson()).toList(),
      "tel": tel,
      'new_classification': classifications,
    };
  }
}
