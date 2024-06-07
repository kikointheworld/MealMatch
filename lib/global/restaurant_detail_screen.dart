import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/restaurant.dart';
import '../models/review.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  int _currentTabIndex = 0;

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
  }

  void _scrollToSection(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(_appBarOpacity),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Opacity(
          opacity: _appBarOpacity,
          child: Text(widget.restaurant.koName,
              style: const TextStyle(color: Colors.black)),
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
                    /*Expanded(
                      flex: 1,
                      child: Column(
                        children: widget.restaurant.mainImages!
                            .skip(1)
                            .map(
                              (image) => Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),*/
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
                            Text(
                              widget.restaurant.koName,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.restaurant.koCategory,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // Favorite logic
                        },
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
                if (_currentTabIndex == 0) buildHomeContent(),
                if (_currentTabIndex == 1) buildMenuContent(),
                if (_currentTabIndex == 2) buildReviewList(widget.restaurant.reviews),
              ],
            ),
          ),
        ],
      ),
    );
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
          color:
              _currentTabIndex == index ? Colors.green[100] : Colors.transparent,
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
          Text(widget.restaurant.koAddress,
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          /*Text(widget.restaurant.enOpeningHours,
              style: const TextStyle(fontSize: 14)),
          SizedBox(height: 4),*/
          Text("${widget.restaurant.tel}",
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          const Text("Menu",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          buildMenuGrid(),
          const SizedBox(height: 16),
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

  Widget buildMenuGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: widget.restaurant.menus.length < 4
          ? widget.restaurant.menus.length
          : 4,
      itemBuilder: (context, index) {
        final menu = widget.restaurant.menus[index];
        return Column(
          children: [
            Expanded(
              child: Image.network(
                menu.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(menu.koName, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(menu.enPrice, style: const TextStyle(fontSize: 12)),
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                // 리뷰 쓰기 버튼 클릭 시 로직 추가
              },
              child: const Text("Write a Review"),
            ),
          ),
          const SizedBox(height: 16),
          ...reviews.map((review) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.koUsername,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.enContent,
                        style: const TextStyle(fontSize: 13, color: Colors.black),
                      ),
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
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    menu.imageUrl ?? '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menu.koName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(menu.enPrice,
                          style: const TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
