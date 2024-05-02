import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RestaurantInfoWidget extends StatelessWidget {
  final String name;
  final String category;
  final String address;
  final String openingHours;
  final List<String> mainImages;
  final List<dynamic> reviews;

  const RestaurantInfoWidget({
    Key? key,
    required this.name,
    required this.category,
    required this.address,
    required this.openingHours,
    required this.mainImages,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16/9,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: mainImages.map((item) => Image.network(item, fit: BoxFit.cover)).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: <Widget>[
              Text("$name  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(category, textAlign: TextAlign.right),
              Spacer(),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Favorite logic
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(address),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(openingHours),
        ),
        SizedBox(height: 8.0),
        buildHorizontalReviewList(reviews),
      ],
    );
  }

  Widget buildHorizontalReviewList(List<dynamic> reviews) {
    return Container(
      height: 120,
      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return Container( // 한 번 넘기면 하나의 리뷰만 나오도록 수정할 예정
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review[0], style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(review[1]),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}