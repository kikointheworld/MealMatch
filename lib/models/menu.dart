import 'package:mealmatch/models/info.dart';

class Menu {
  final String? enContent;
  final String enName;
  final String enPrice;
  final String? imageUrl;
  final Info info;
  final String? koContent;
  final String koName;
  final String koPrice;

  Menu({
    this.enContent,
    required this.enName,
    required this.enPrice,
    this.imageUrl,
    required this.info,
    this.koContent,
    required this.koName,
    required this.koPrice,
  });

  factory Menu.fromJson(Map<dynamic, dynamic> json) {
    return Menu(
      enContent: json["en_content"],
      enName: json["en_name"],
      enPrice: json["en_price"],
      imageUrl: json["image"],
      info: Info.fromJson(json["info"]),
      koContent: json["ko_content"],
      koName: json["ko_name"],
      koPrice: json["ko_price"],
    );
  }

  static List<Menu> fromList(List<dynamic> list) {
    return list.map((item) => Menu.fromJson(item as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "en_content": enContent,
      "en_name": enName,
      "en_price": enPrice,
      "image": imageUrl,
      "info": info.toJson(),
      "ko_content": koContent,
      "ko_name": koName,
      "ko_price": koPrice,
    };
  }
}
