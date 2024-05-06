class Review {
  final String username;
  final String comment;
  final List<String>? tags;
  final List<String>? images;

  Review({
    required this.username,
    required this.comment,
    this.tags,
    this.images,
  });

  // Adjusted constructor to handle null lists
  factory Review.fromList(List<dynamic> data) {
    return Review(
      username: data[0] ?? 'Anonymous',
      comment: data[1] ?? 'No comment provided',
      tags: data.length > 2 && data[2] != null ? List<String>.from(data[2]) : [],
      images: data.length > 3 && data[3] != null ? List<String>.from(data[3]) : [],
    );
  }
}
