class Review {
  final String enUsername;
  final String enContent;
  final List<String>? enAttributes;
  final String koUsername;
  final String koContent;
  final List<String>? koAttributes;
  final List<String>? images;

  Review({
    required this.enUsername,
    required this.enContent,
    this.enAttributes,
    required this.koUsername,
    required this.koContent,
    this.koAttributes,
    this.images,
  });

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      enUsername: json["en_name"],
      enContent: json["en_content"],
      enAttributes: json["en_attributes"] != null ? List<String>.from(json["en_attributes"]) : null,
      koUsername: json["ko_name"],
      koContent: json["ko_content"],
      koAttributes: json["ko_attributes"] != null ? List<String>.from(json["ko_attributes"]) : null,
      images: json["images"] != null ? List<String>.from(json["images"]) : null,
    );
  }
}



// class Review {
//   final String enUsername;
//   final String enContent;
//   final List<String>? enAttributes;
//   final String koUsername;
//   final String koContent;
//   final List<String>? koAttributes;
//   final List<String>? images;
//
//   Review({
//     required this.enUsername,
//     required this.enContent,
//     this.enAttributes,
//     required this.koUsername,
//     required this.koContent,
//     this.koAttributes,
//     this.images
//   });
//
//   // Adjusted constructor to handle null lists
//   factory Review.fromJson(Map<String, dynamic> json) {
//     return Review(
//       enUsername: json["en_name"],
//       enContent: json["en_content"],
//       enAttributes: json.containsKey("en_attributes") ? json["en_attributes"] : null,
//       koUsername: json["ko_name"],
//       koContent: json["ko_content"],
//       koAttributes: json.containsKey("ko_attributes") ? json["ko_attributes"] : null,
//       images: json.containsKey("images") ? json["images"] : null
//     );
//   }
// }

// class Review {
//   final String username;
//   final String comment;
//   final List<String>? tags;
//   final List<String>? images;
//
//   Review({
//     required this.username,
//     required this.comment,
//     this.tags,
//     this.images,
//   });
//
//   // Adjusted constructor to handle null lists
//   factory Review.fromList(List<dynamic> data) {
//     return Review(
//       username: data[0] ?? 'Anonymous',
//       comment: data[1] ?? 'No comment provided',
//       tags: data.length > 2 && data[2] != null ? List<String>.from(data[2]) : [],
//       images: data.length > 3 && data[3] != null ? List<String>.from(data[3]) : [],
//     );
//   }
// }
