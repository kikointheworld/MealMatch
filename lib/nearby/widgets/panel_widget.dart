import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:mealmatch/services/data_manager.dart';
import '../../global/restaurant_detail_screen.dart';
import '../../models/restaurant.dart';
import 'restaurant_info_widget.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final List<Restaurant> restaurants;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
    this.restaurants = const [], // 빈 리스트로 초기화
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildDragHandle(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            controller: controller,
            children: <Widget>[
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "Nearby Restaurants",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                ),
              ),
              buildRestaurantList(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDragHandle() => GestureDetector(
    onTap: togglePanel,
    child: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  void togglePanel() => panelController.isPanelOpen ? panelController.close() : panelController.open();

  Widget buildRestaurantList(BuildContext context) {
    if (restaurants.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "No restaurants found in this area.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    int itemCount = restaurants.length < 20 ? restaurants.length : 20;

    return Column(
      children: List.generate(itemCount, (index) {
        final restaurant = restaurants[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(restaurant: restaurant),
              ),
            );
          },
          child: RestaurantInfoWidget(restaurant: restaurant),
        );
        /*return RestaurantInfoWidget(
          restaurant: restaurant, // Restaurant 객체를 직접 전달
        );*/
      }),
    );
  }
}
