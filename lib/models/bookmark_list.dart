import 'restaurant.dart';

class BookmarkList {
  final String name;
  final String color;
  final String? description;
  final bool isPublic;
  final List<Restaurant> restaurants;

  BookmarkList({
    required this.name,
    required this.color,
    this.description,
    this.isPublic = false,
    this.restaurants = const [],
  });

  factory BookmarkList.fromJson(Map<dynamic, dynamic> json) {
    return BookmarkList(
      name: json["name"],
      color: json["color"],
      description: json["description"],
      isPublic: json["isPublic"],
      restaurants: json["restaurants"] != null
          ? (json["restaurants"] as List).map((x) => Restaurant.fromJson(x)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "color": color,
      "description": description,
      "isPublic": isPublic,
      "restaurants": restaurants.map((restaurant) => restaurant.toJson()).toList(),
    };
  }
}
