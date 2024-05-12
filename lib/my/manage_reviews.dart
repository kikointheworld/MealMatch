import 'package:flutter/material.dart';

class ManageReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Reviews Page'),
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
