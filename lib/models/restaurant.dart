import 'package:mealmatch/models/menu.dart';
import 'package:mealmatch/models/review.dart';

class Restaurant {
  final String name;
  final String address;
  final String category;
  final List<String> mainImages;
  final List<Menu> menus;
  final String openingHours;
  final List<Review> reviews;

  Restaurant({
    required this.name,
    required this.address,
    required this.category,
    required this.mainImages,
    required this.menus,
    required this.openingHours,
    required this.reviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      address: json['address'],
      category: json['category'],
      mainImages: List<String>.from(json['main_images'] ?? []),
      menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromList(x as List<dynamic>)).toList() : [],
      openingHours: json['opening_hours'],
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromList(x as List<dynamic>)).toList() : [],
    );
  }
}
