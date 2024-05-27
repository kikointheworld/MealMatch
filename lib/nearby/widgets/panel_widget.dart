import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'restaurant_info_widget.dart';
import 'package:mealmatch/services/data_manager.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

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
              buildRestaurantList(dataManager),
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

  Widget buildRestaurantList(DataManager dataManager) {
    int itemCount = dataManager.restaurants.length < 20 ? dataManager.restaurants.length : 20;

    return Column(
      children: List.generate(itemCount, (index) {
        final restaurant = dataManager.restaurants[index];
        if (restaurant != null) {
          return RestaurantInfoWidget(
            name: restaurant.enName,
            category: restaurant.enCategory,
            address: restaurant.enAddress,
            openingHours: restaurant.enOpeningHours,
            mainImages: restaurant.mainImages,
            reviews: restaurant.reviews,
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }
}
