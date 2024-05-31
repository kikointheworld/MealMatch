import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../models/review.dart';
import '../../models/restaurant.dart';
import '../../services/data_manager.dart';

class RestaurantInfoWidget extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantInfoWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _RestaurantInfoWidgetState createState() => _RestaurantInfoWidgetState();
}

class _RestaurantInfoWidgetState extends State<RestaurantInfoWidget> {
  Map<String, bool> checkedLists = {};
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final dataManager = Provider.of<DataManager>(context, listen: false);
    dataManager.bookmarkLists.forEach((bookmarkList) {
      if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
        isFavorite = true;
      }
      checkedLists[bookmarkList.name] = bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: widget.restaurant.mainImages?.map((item) => Image.network(item, fit: BoxFit.cover)).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Text(
                widget.restaurant.enName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                widget.restaurant.enCategory,
                textAlign: TextAlign.right,
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  _showBookmarkDialog(context);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            widget.restaurant.enAddress,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            widget.restaurant.enOpeningHours,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8.0),
        buildHorizontalReviewList(widget.restaurant.reviews),
        const SizedBox(height: 20.0),
      ],
    );
  }

  void _showBookmarkDialog(BuildContext context) {
    final dataManager = Provider.of<DataManager>(context, listen: false);
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
    bool wasFavorite = isFavorite;
    isFavorite = false;

    checkedLists.forEach((listName, isChecked) {
      final bookmarkList = dataManager.bookmarkLists.firstWhere((list) => list.name == listName);
      if (isChecked) {
        if (!bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.addRestaurantToBookmarkList(widget.restaurant, bookmarkList);
        }
        isFavorite = true; // 북마크 리스트에 추가되었으면 favorite 상태로 설정
      } else {
        if (bookmarkList.restaurants.any((r) => r.enName == widget.restaurant.enName)) {
          dataManager.removeRestaurantFromBookmarkList(widget.restaurant, bookmarkList);
        }
      }
    });

    if (wasFavorite != isFavorite) {
      setState(() {}); // favorite 상태가 변경되었으면 화면을 갱신
    }
  }

  Widget buildHorizontalReviewList(List<dynamic> reviews) {
    PageController controller = PageController(viewportFraction: 0.95);

    return Container(
      height: 120,
      child: PageView.builder(
        controller: controller,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return Card(
            color: Colors.lightGreen[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.koUsername,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    review.enContent,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
