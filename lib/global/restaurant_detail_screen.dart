import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.restaurant.enName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.restaurant.enAddress, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(widget.restaurant.enCategory, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(widget.restaurant.enOpeningHours, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),    );
  }
}
