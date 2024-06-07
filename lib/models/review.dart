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

  Map<String, dynamic> toJson() {
    return {
      "en_name": enUsername,
      "en_content": enContent,
      "en_attributes": enAttributes,
      "ko_name": koUsername,
      "ko_content": koContent,
      "ko_attributes": koAttributes,
      "images": images,
    };
  }
}
