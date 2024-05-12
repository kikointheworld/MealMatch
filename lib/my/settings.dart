import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: Text('NEW', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
