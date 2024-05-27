import 'package:carousel_slider/carousel_slider.dart';
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mainImages != null && mainImages!.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: mainImages!.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  );
                }).toList(),
              ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(category, style: TextStyle(fontSize: 16)),
            Text(address, style: TextStyle(fontSize: 16)),
            Text('Opening Hours: $openingHours', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              'Reviews:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('English: ${review.enUsername} - ${review.enContent}'),
                    Text('Korean: ${review.koUsername} - ${review.koContent}'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
