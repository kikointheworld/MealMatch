import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mealmatch/const/nearby_places_const.dart';

class NearbyPlacesWidget extends StatefulWidget {
  final Function(String) onPlaceClickListener;
  final Function(bool) onComplete;

  const NearbyPlacesWidget({
    super.key,
    required this.onPlaceClickListener,
    required this.onComplete,
  });

  @override
  _NearbyPlacesWidgetState createState() => _NearbyPlacesWidgetState();
}

class _NearbyPlacesWidgetState extends State<NearbyPlacesWidget> {
  Map<String, bool> _buttonStates = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    _initializeButtonStates();
    _loadUserDietPreferences();
  }

  void _initializeButtonStates() {
    for (var place in NearbyPlacesConst.nearbyPlacesTexts) {
      _buttonStates[place] = false;
    }
  }

  Future<void> _loadUserDietPreferences() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DatabaseReference dietRef =
          _database.reference().child('users').child(user.uid).child('diet');
      DatabaseEvent event = await dietRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<int, String> dietMapping = {
          0: 'No Special Preference',
          1: 'Vegan',
          2: 'Lacto-Vegetarian',
          3: 'Halal',
          4: 'Pescatarian',
          5: 'Kosher',
          6: 'Dairy-Free',
          7: 'Egg-Free',
        };

        for (DataSnapshot child in snapshot.children) {
          int diet = child.value as int;
          if (diet == 0) {
            break;
          } else if (dietMapping.containsKey(diet)) {
            String preference = dietMapping[diet]!;
            _buttonStates[preference] = true;
            _toggleButton(preference, initialLoad: true);
          }
        }

        setState(() {});
      }
    }
  }

  void _toggleButton(String place, {bool initialLoad = false}) {
    setState(() {
      if (!initialLoad) {
        _buttonStates[place] = !(_buttonStates[place] ?? false);
      }
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
        itemCount: NearbyPlacesConst.nearbyPlacesTexts.length,
        itemBuilder: (context, index) {
          String singlePlaceText = NearbyPlacesConst.nearbyPlacesTexts[index];
          IconData? singlePlaceIcon =
              NearbyPlacesIconsConst.nearbyPlacesIcons[singlePlaceText];
          bool isActive = _buttonStates[singlePlaceText] ?? false;
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
                  if (singlePlaceIcon != null)
                    Icon(singlePlaceIcon,
                        color: isActive ? Colors.white : Colors.black),
                  const SizedBox(width: 5),
                  Text(
                    singlePlaceText,
                    style: TextStyle(
                        color: isActive ? Colors.white : Colors.black),
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
