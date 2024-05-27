import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'restaurant_info_widget.dart';
import 'package:mealmatch/models/restaurant.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final List<Restaurant> restaurants;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
    required this.restaurants,
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
              buildRestaurantList(),
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

  Widget buildRestaurantList() {
    int itemCount = restaurants.length < 20 ? restaurants.length : 20;

    return Column(
      children: List.generate(itemCount, (index) {
        final restaurant = restaurants[index];
        return RestaurantInfoWidget(
          name: restaurant.enName,
          category: restaurant.enCategory,
          address: restaurant.enAddress,
          openingHours: restaurant.enOpeningHours,
          mainImages: restaurant.mainImages,
          reviews: restaurant.reviews,
        );
      }),
    );
  }
}
