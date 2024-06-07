import 'package:flutter/material.dart';
import 'package:mealmatch/const/nearby_places_const.dart';
import 'package:mealmatch/nearby/widgets/single_nearby_places_widget.dart';

class NearbyPlacesWidget extends StatefulWidget {
  final Function(String) onPlaceClickListener;
  final Function(bool) onComplete;

  const NearbyPlacesWidget({super.key, required this.onPlaceClickListener, required this.onComplete});

  @override
  _NearbyPlacesWidgetState createState() => _NearbyPlacesWidgetState();
}

class _NearbyPlacesWidgetState extends State<NearbyPlacesWidget> {
  Map<String, bool> _buttonStates = {};

  @override
  void initState() {
    super.initState();
    // Initialize button states
    for (var place in NearbyPlacesConst.nearbyPlacesTexts) {
      _buttonStates[place] = false;
    }
  }

  void _toggleButton(String place) {
    setState(() {
      _buttonStates[place] = !(_buttonStates[place] ?? false); // Check for null and provide a default value
      widget.onPlaceClickListener(place);
    });
  }

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
          bool isActive = _buttonStates[singlePlaceText] ?? false; // Check for null and provide a default value
          return GestureDetector(
            onTap: () {
              _toggleButton(singlePlaceText);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: isActive ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? Colors.green : Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  Icon(singlePlaceIcon, color: isActive ? Colors.white : Colors.black),
                  const SizedBox(width: 5),
                  Text(
                    singlePlaceText,
                    style: TextStyle(color: isActive ? Colors.white : Colors.black),
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
