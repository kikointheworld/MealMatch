import 'restaurant.dart';

class BookmarkList {
  final String name;
  final String color;
  final String? description;
  final bool isPublic;
  final List<Restaurant>? restaurants;

  BookmarkList({
    required this.name,
    required this.color,
    this.description,
    required this.isPublic,
    this.restaurants
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "color": color,
      "description": description,
      "isPublic": isPublic,
      "restaurants" : restaurants
    };
  }
}
