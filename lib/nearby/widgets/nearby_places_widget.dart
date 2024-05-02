import 'package:flutter/material.dart';
import 'package:mealmatch/const/nearby_places_const.dart';
import 'package:mealmatch/nearby/widgets/single_nearby_places_widget.dart';

class NearbyPlacesWidget extends StatelessWidget {
  final Function(String) onPlaceClickListner;
  final Function(bool) onComplete;

  const NearbyPlacesWidget({super.key, required this.onPlaceClickListner, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 45,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: NearbyPlacesIconsConst.nearbyPlacesIcons.length,
        itemBuilder: (context, index) {
          IconData singlePlaceIcon = NearbyPlacesIconsConst.nearbyPlacesIcons[index];
          String singlePlaceText = NearbyPlacesConst.nearbyPlacesTexts[index];
          return SingleNearbyPlaceWidget(
            onPlaceClickListener: (place) {
              onPlaceClickListner(place);
            },
            place: singlePlaceText,
            icon: singlePlaceIcon
          );
        },
      ),
    );
  }
}
