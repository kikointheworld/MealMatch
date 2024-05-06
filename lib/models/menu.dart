class Menu {
  final String name;
  final String? description;
  final String price;
  final String? imageUrl;

  Menu({
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
  });

  factory Menu.fromList(List<dynamic> data) {
    return Menu(
      name: data[0],
      description: data[1], // This can be null
      price: data[2],
      imageUrl: data.length > 3 && data[3] != null ? data[3] : "",
    );
  }
}
