import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mealmatch/config/palette.dart';

class DietaryPreferencesPage extends StatefulWidget {
  @override
  _DietaryPreferencesPageState createState() => _DietaryPreferencesPageState();
}

class _DietaryPreferencesPageState extends State<DietaryPreferencesPage> {
  Map<String, bool> dietaryPreferences = {
    'No Special Preference': false,
    'Vegan': false,
    'Lacto-Vegetarian': false,
    'Halal': false,
    'Pescatarian': false,
    'Kosher': false,
    'Dairy-Free': false,
    'Egg-Free': false,
  };

  Map<String, String> dietaryDescriptions = {
    'No Special Preference': 'No specific dietary restrictions.',
    'Vegan': 'No animal products.',
    'Lacto-Vegetarian': 'No meat, eggs; dairy allowed.',
    'Halal': 'Permissible under Islamic law.',
    'Pescatarian': 'No meat; fish allowed.',
    'Kosher': 'Permissible under Jewish law.',
    'Dairy-Free': 'No dairy products.',
    'Egg-Free': 'No eggs or egg products.',
  };

  Map<String, IconData> dietaryIcons = {
    'No Special Preference': Icons.restaurant,
    'Vegan': Icons.eco,
    'Lacto-Vegetarian': Icons.local_florist,
    'Halal': Icons.restaurant_menu,
    'Pescatarian': Icons.set_meal,
    'Kosher': Icons.verified_user,
    'Dairy-Free': Icons.no_meals,
    'Egg-Free': Icons.egg,
  };

  @override
  void initState() {
    super.initState();
    _fetchUserDietaryPreferences();
  }

  Future<void> _fetchUserDietaryPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      DataSnapshot snapshot = await userRef.get();
      if (snapshot.exists) {
        List<dynamic> dietList = snapshot.child('diet').value as List<dynamic>;
        setState(() {
          dietList.forEach((diet) {
            if (diet == 0) {
              dietaryPreferences['No Special Preference'] = true;
            } else if (diet == 1) {
              dietaryPreferences['Vegan'] = true;
            } else if (diet == 2) {
              dietaryPreferences['Lacto-Vegetarian'] = true;
            } else if (diet == 3) {
              dietaryPreferences['Halal'] = true;
            } else if (diet == 4) {
              dietaryPreferences['Pescatarian'] = true;
            } else if (diet == 5) {
              dietaryPreferences['Kosher'] = true;
            } else if (diet == 6) {
              dietaryPreferences['Dairy-Free'] = true;
            } else if (diet == 7) {
              dietaryPreferences['Egg-Free'] = true;
            }
          });
        });
      }
    }
  }

  void _updateDietaryPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<int> updatedDiet = [];
      dietaryPreferences.forEach((key, value) {
        if (value) {
          if (key == 'No Special Preference') {
            updatedDiet.add(0);
          } else if (key == 'Vegan') {
            updatedDiet.add(1);
          } else if (key == 'Lacto-Vegetarian') {
            updatedDiet.add(2);
          } else if (key == 'Halal') {
            updatedDiet.add(3);
          } else if (key == 'Pescatarian') {
            updatedDiet.add(4);
          } else if (key == 'Kosher') {
            updatedDiet.add(5);
          } else if (key == 'Dairy-Free') {
            updatedDiet.add(6);
          } else if (key == 'Egg-Free') {
            updatedDiet.add(7);
          }
        }
      });
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      await userRef.update({'diet': updatedDiet});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dietary Preferences'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: ListView(
        children: dietaryPreferences.keys.map((String key) {
          return Column(
            children: [
              CheckboxListTile(
                title: Row(
                  children: <Widget>[
                    Icon(dietaryIcons[key], color: Palette.primary200),
                    SizedBox(width: 10),
                    Text(key),
                  ],
                ),
                value: dietaryPreferences[key],
                activeColor: Palette.primary200,
                onChanged: (bool? value) {
                  setState(() {
                    dietaryPreferences[key] = value!;
                  });
                  _updateDietaryPreferences();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dietaryDescriptions[key]!,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
