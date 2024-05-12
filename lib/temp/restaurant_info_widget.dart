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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(width: 8,),
              Text(category, textAlign: TextAlign.right),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Favorite logic
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(address, overflow: TextOverflow.ellipsis,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(openingHours), // 들어갈 내용인지는 애매함.
        ),
        const SizedBox(height: 8.0),
        buildHorizontalReviewList(reviews),
        const SizedBox(height: 20.0,),
      ],
    );
  }

  Widget buildHorizontalReviewList(List<dynamic> reviews) {
    PageController controller = PageController(viewportFraction: 0.95);

    return Container(
      height: 120,
      child: PageView.builder(
        controller: controller,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return Card(
            color: Colors.lightGreen[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    review[1],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}