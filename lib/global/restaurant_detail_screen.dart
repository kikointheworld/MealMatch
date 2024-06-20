import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import 'package:provider/provider.dart';
import '../services/data_manager.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  int _currentTabIndex = 0;
  Map<String, bool> checkedLists = {};
  bool isFavorite = false;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double newOpacity = offset / 150.0;
      if (newOpacity > 1.0) newOpacity = 1.0;
      setState(() {
        _appBarOpacity = newOpacity;
      });
    });

    final dataManager = Provider.of<DataManager>(context, listen: false);
    dataManager.bookmarkLists.forEach((bookmarkList) {
      checkedLists[bookmarkList.name] = bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName);
    });
    isFavorite = checkedLists.values.any((checked) => checked);
  }

  void _scrollToSection(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(_appBarOpacity),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Opacity(
          opacity: _appBarOpacity,
          child: Text(widget.restaurant.koName, style: const TextStyle(color: Colors.black)),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          widget.restaurant.mainImages![0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.restaurant.koName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(widget.restaurant.koCategory, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.black),
                        onPressed: () => _showBookmarkDialog(context, dataManager),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 40.0,
              maxHeight: 40.0,
              child: Container(
                color: Colors.white,
                child: buildTabBar(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (_currentTabIndex == 0) buildHomeContent(),  // 홈 탭에 대한 내용
                if (_currentTabIndex == 1) buildMenuContent(),  // 메뉴 탭에 대한 내용
                if (_currentTabIndex == 2) buildReviewList(widget.restaurant.reviews), // 리뷰 탭에 대한 내용
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showReviewDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showBookmarkDialog(BuildContext context, DataManager dataManager) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.restaurant.enName),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...dataManager.bookmarkLists.map((bookmarkList) {
                    return CheckboxListTile(
                      title: Text(bookmarkList.name),
                      value: checkedLists[bookmarkList.name] ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          checkedLists[bookmarkList.name] = value!;
                          isFavorite = checkedLists.values.any((checked) => checked);
                        });
                      },
                    );
                  }).toList(),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveBookmarkChanges(dataManager);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveBookmarkChanges(DataManager dataManager) {
    checkedLists.forEach((listName, isChecked) {
      final bookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == listName);
      if (isChecked) {
        if (!bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.addRestaurantToBookmarkList(widget.restaurant, bookmarkList);
        }
      } else {
        if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.removeRestaurantFromBookmarkList(widget.restaurant, bookmarkList);
        }
      }
    });
    setState(() {
      isFavorite = checkedLists.values.any((checked) => checked);
    });
  }

  Widget buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildTab("Home", 0),
        buildTab("Menu", 1),
        buildTab("Reviews", 2),
      ],
    );
  }

  Widget buildTab(String title, int index) {
    return GestureDetector(
      onTap: () => _scrollToSection(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _currentTabIndex == index ? Colors.green[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.restaurant.koAddress,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.phone, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${widget.restaurant.tel}",
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${widget.restaurant.mainOpeningHours}",
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          buildMenuGrid(false), // Home 탭에서는 classification 숨기기
          const SizedBox(height: 16),
          if (widget.restaurant.menus.length > 4)
            Center(
              child: ElevatedButton(
                onPressed: () => _scrollToSection(1),
                child: const Text("More Menu"),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildMenuGrid(bool showClassification) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: widget.restaurant.menus.length < 4 ? widget.restaurant.menus.length : 4,
      itemBuilder: (context, index) {
        final menu = widget.restaurant.menus[index];
        return Column(
          children: [
            Expanded(
              child: menu.imageUrl != null && menu.imageUrl!.isNotEmpty
                  ? Image.network(
                menu.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('image/food.jpg', fit: BoxFit.cover);
                },
              )
                  : Image.asset('image/food.jpg', fit: BoxFit.cover),
            ),
            const SizedBox(height: 4),
            Text(
              menu.koName,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(menu.enPrice, style: const TextStyle(fontSize: 12)),
            if (showClassification)
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: menu.classifications.entries
                    .where((entry) => entry.value == true)
                    .map((entry) => Chip(
                  label: Text(entry.key, style: const TextStyle(fontSize: 12)),
                  backgroundColor: Colors.green[100],
                ))
                    .toList(),
              ),
          ],
        );
      },
    );
  }

  Widget buildReviewList(List<Review> reviews) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...reviews.map((review) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.lightGreenAccent[100],
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.enUsername, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(review.enContent, style: const TextStyle(fontSize: 13, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildMenuContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.restaurant.menus.map((menu) {
          List<Widget> classificationWidgets = menu.getTrueClassifications().map((classification) {
            return Chip(
              label: Text(classification, style: const TextStyle(fontSize: 12)),
              backgroundColor: Colors.green[100],
            );
          }).toList();
          return Card(
            color: Colors.greenAccent[100],
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      menu.imageUrl != null && menu.imageUrl!.isNotEmpty
                          ? Image.network(
                        menu.imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('image/food.jpg', width: 100, height: 100, fit: BoxFit.cover);
                        },
                      )
                          : Image.asset('image/food.jpg', width: 100, height: 100, fit: BoxFit.cover),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu.koName,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              menu.enPrice,
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: classificationWidgets,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }



  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Write a Review"),
          content: TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: "Write your review here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _saveReview(_reviewController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _saveReview(String reviewContent) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(user.uid);
      DataSnapshot userSnapshot = await userRef.once().then((event) => event.snapshot);

      if (userSnapshot.exists) {
        Map<dynamic, dynamic> userData = userSnapshot.value as Map<dynamic, dynamic>;
        String username = userData['username'] ?? 'Anonymous';

        // 현재 날짜와 시간을 생성
        String createdAt = DateTime.now().toIso8601String();

        // 새 리뷰 객체 생성
        Review newReview = Review(
          enUsername: username,
          enContent: reviewContent,
          createdAt: createdAt,
        );

        DatabaseReference restaurantRef = FirebaseDatabase.instance.ref().child('restaurants').child(widget.restaurant.id.toString());
        DataSnapshot restaurantSnapshot = await restaurantRef.once().then((event) => event.snapshot);

        List<dynamic> reviews;
        if (restaurantSnapshot.value != null && (restaurantSnapshot.value as Map)['reviews'] is List) {
          reviews = List.from((restaurantSnapshot.value as Map)['reviews']);
        } else {
          reviews = [];
        }
        reviews.add(newReview.toJson());
        await restaurantRef.child('reviews').set(reviews);

        // 리뷰를 유저 데이터에 추가
        DatabaseReference userReviewsRef = userRef.child('reviews');
        DataSnapshot userReviewsSnapshot = await userReviewsRef.once().then((event) => event.snapshot);

        List<dynamic> userReviews;
        if (userReviewsSnapshot.value is List) {
          userReviews = List.from(userReviewsSnapshot.value as List);
        } else {
          userReviews = [];
        }
        userReviews.add({
          'restaurantId': widget.restaurant.id,
          'review': newReview.toJson(),
        });
        await userReviewsRef.set(userReviews);

        // 리뷰가 추가된 후 UI 업데이트
        setState(() {
          widget.restaurant.reviews.add(newReview);
        });
      }
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight || oldDelegate.child != child;
  }
}
