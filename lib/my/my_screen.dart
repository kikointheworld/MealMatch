import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mealmatch/my/dietary_preferences.dart';
import 'package:mealmatch/my/edit_profile_info.dart';
import 'package:mealmatch/my/manage_reviews.dart';
import 'package:mealmatch/my/notification_settings.dart';
import 'package:mealmatch/my/settings.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('image/human.jpeg'),
                        ),
                        Positioned(
                          right: -9,
                          bottom: -9,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                              ),
                              onPressed: () {
                                // 사진 변경 로직
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Tamer',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text('I\'m not vegan',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Edit Profile Info'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileInfoPage(
                      initialUserName: "Tamer",
                      initialEmail: "tamer@gmail.com",
                    ),
                  ));
                },
              ),
              ListTile(
                title: Text('Notification Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationSettingsPage(),
                  ));
                },
              ),
              ListTile(
                title: Text('Dietary Preferences'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DietaryPreferencesPage(),
                  ));
                },
              ),
              ListTile(
                title: Text('Manage Reviews'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManageReviewsPage(),
                  ));
                },
              ),
              ListTile(
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
