import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _isNotificationEnabled = false;

  @override
  void initState() {
    super.initState();
    _fetchNotificationSetting();
  }

  Future<void> _fetchNotificationSetting() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      DataSnapshot snapshot = await userRef.child('notification').get();
      if (snapshot.exists) {
        setState(() {
          _isNotificationEnabled = snapshot.value as bool;
        });
      }
    }
  }

  void _updateNotificationSetting(bool newValue) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      await userRef.update({'notification': newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enable Notifications', style: TextStyle(fontSize: 24)),
            Switch(
              value: _isNotificationEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _isNotificationEnabled = newValue;
                });
                _updateNotificationSetting(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
