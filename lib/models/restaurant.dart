import 'package:mealmatch/models/menu.dart';
import 'package:mealmatch/models/review.dart';

class Restaurant {
  final int id; // ID 필드 추가
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
    required this.id, // ID 필드 초기화
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
      id: json["id"] ?? 999, // ID가 null인 경우 기본값 0 설정
      enName: json["name"]?["enName"] ?? '',
      enAddress: json["address"]?["enAddress"] ?? '',
      enCategory: json["category"]?["enCategory"] ?? '',
      enOpeningHours: json["opening_hours"]?["en"] ?? '',
      koName: json["name"]?["koName"] ?? '',
      koAddress: json["address"]?["koAddress"] ?? '',
      koCategory: json["category"]?["koCategory"] ?? '',
      koOpeningHours: json["opening_hours"]?["ko"] ?? '',
      mainImages: json["main_images"] != null ? List<String>.from(json["main_images"]) : [],
      latitude: json["address"]?["lat"] ?? 0.0,
      longitude: json["address"]?["lng"] ?? 0.0,
      menus: json['menus'] != null ? (json['menus'] as List).map((x) => Menu.fromJson(x)).toList() : [],
      reviews: json['reviews'] != null ? (json['reviews'] as List).map((x) => Review.fromJson(x)).toList() : [],
      tel: json["tel"] ?? '',
      mainOpeningHours: json["opening_hours"]?["main"] ?? '',
      classifications: json['new_classification'] != null ? Map<String, bool>.from(json['new_classification']) : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, // ID를 JSON에 포함
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
      'classification': classifications,
    };
  }
}
