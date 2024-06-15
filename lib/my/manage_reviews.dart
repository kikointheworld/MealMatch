import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ManageReviewsPage extends StatefulWidget {
  @override
  _ManageReviewsPageState createState() => _ManageReviewsPageState();
}

class _ManageReviewsPageState extends State<ManageReviewsPage> {
  final DatabaseReference _reviewsRef =
      FirebaseDatabase.instance.reference().child('users');
  final DatabaseReference _restaurantsRef =
      FirebaseDatabase.instance.reference().child('restaurants');
  User? _user;
  List<Map<dynamic, dynamic>> _reviews = [];
  Map<int, String> _restaurantNames = {};

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _user = user;
      DatabaseReference userReviewsRef =
          _reviewsRef.child(user.uid).child('reviews');
      DatabaseEvent event = await userReviewsRef.once();

      if (event.snapshot.value != null) {
        dynamic data = event.snapshot.value;
        if (data is Map<dynamic, dynamic>) {
          data.forEach((key, value) {
            _reviews.add({'key': key, ...value});
          });
        } else if (data is List<dynamic>) {
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) {
              _reviews.add({'key': i, ...data[i]});
            }
          }
        }
        _reviews.sort((a, b) =>
            b['review']['created_at'].compareTo(a['review']['created_at']));
        await _fetchRestaurantNames();
        setState(() {});
      }
    }
  }

  Future<void> _fetchRestaurantNames() async {
    for (var review in _reviews) {
      int restaurantId = review['restaurantId'];
      DatabaseEvent restaurantEvent =
          await _restaurantsRef.child(restaurantId.toString()).once();
      if (restaurantEvent.snapshot.value != null) {
        _restaurantNames[restaurantId] =
            restaurantEvent.snapshot.child('name/enName').value as String;
      }
    }
  }

  void _deleteReview(dynamic key) async {
    if (_user != null) {
      DatabaseReference userReviewRef =
          _reviewsRef.child(_user!.uid).child('reviews').child(key.toString());
      await userReviewRef.remove();
      setState(() {
        _reviews.removeWhere((review) => review['key'] == key);
      });
    }
  }

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
      body: _reviews.isEmpty
          ? Center(
              child:
                  Text('No reviews available', style: TextStyle(fontSize: 24)),
            )
          : ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                Map review = _reviews[index];
                int restaurantId = review['restaurantId'];
                String reviewContent = review['review']['en_content'] as String;
                String createdAt = review['review']['created_at'] as String;
                String restaurantName =
                    _restaurantNames[restaurantId] ?? 'Unknown';

                DateTime dateTime = DateTime.parse(createdAt);
                String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

                return ListTile(
                  title: Text('$restaurantName'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Review: $reviewContent'),
                      Text('Created At: $formattedDate'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteReview(review['key']),
                  ),
                );
              },
            ),
    );
  }
}
