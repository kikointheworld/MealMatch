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
}


// class Menu {
//   final String? enContent;
//   final String enName;
//   final String enPrice;
//   final String? imageUrl;
//   final Info info;
//   final String? koContent;
//   final String koName;
//   final String koPrice;
//
//
//   Menu({
//     this.enContent,
//     required this.enName,
//     required this.enPrice,
//     this.imageUrl,
//     required this.info,
//     this.koContent,
//     required this.koName,
//     required this.koPrice
//   });
//
//   factory Menu.fromJson(Map<String, dynamic> json) {
//     return Menu(
//         enContent: json.containsKey("en_content") ? json["en_content"] : null,
//         enName: json["en_name"],
//         enPrice: json["en_price"],
//       imageUrl: json.containsKey("image") ? json["image"] : null,
//       info: json["info"],
//         koContent: json.containsKey("ko_content") ? json["ko_content"] : null,
//         koName: json["ko_name"],
//         koPrice: json["ko_price"]
//     );
//   }
// }



// class Menu {
//   final String name;
//   final String? description;
//   final String price;
//   final String? imageUrl;
//
//   Menu({
//     required this.name,
//     this.description,
//     required this.price,
//     this.imageUrl,
//   });
//
//   factory Menu.fromList(List<dynamic> data) {
//     return Menu(
//       name: data[0],
//       description: data[1], // This can be null
//       price: data[2],
//       imageUrl: data.length > 3 && data[3] != null ? data[3] : "",
//     );
//   }
// }
