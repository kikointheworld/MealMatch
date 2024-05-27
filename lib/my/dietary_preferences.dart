import 'package:flutter/material.dart';

class DietaryPreferencesPage extends StatefulWidget {
  @override
  _DietaryPreferencesPageState createState() => _DietaryPreferencesPageState();
}

class _DietaryPreferencesPageState extends State<DietaryPreferencesPage> {
  String _dietaryPreference = 'all'; // Initial selected value

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
        children: <Widget>[
          buildRadioListTile('All', Icons.fastfood, 'all'),
          buildRadioListTile('Vegan', Icons.eco, 'vegan'),
          buildRadioListTile('Vegetarian', Icons.local_florist, 'vegetarian'),
          buildRadioListTile('Keto', Icons.whatshot, 'keto'),
          buildRadioListTile('Halal', Icons.restaurant_menu, 'halal'),
          buildRadioListTile(
              'Gluten-Free', Icons.no_meals_ouline, 'gluten-free'),
        ],
      ),
    );
  }

  RadioListTile<String> buildRadioListTile(
      String title, IconData icon, String value) {
    return RadioListTile<String>(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      value: value,
      groupValue: _dietaryPreference,
      onChanged: (value) {
        setState(() {
          _dietaryPreference = value!;
        });
      },
    );
  }
}
