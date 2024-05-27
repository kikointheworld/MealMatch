import 'package:flutter/material.dart';
import 'package:mealmatch/models/review.dart';

class RestaurantInfoWidget extends StatelessWidget {
  final String name;
  final String category;
  final String address;
  final String openingHours;
  final List<String>? mainImages;
  final List<Review> reviews;

  const RestaurantInfoWidget({
    Key? key,
    required this.name,
    required this.category,
    required this.address,
    required this.openingHours,
    this.mainImages,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          category,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          address,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          'Opening Hours: $openingHours',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 8),
        if (mainImages != null && mainImages!.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mainImages!.length,
              itemBuilder: (context, index) {
                return Image.network(mainImages![index]);
              },
            ),
          ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reviews.map((review) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.enUsername,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  review.enContent,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
