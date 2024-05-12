import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:mealmatch/temp/restaurant_info_widget.dart';

//for test
List<Map<String, dynamic>> restaurants = [
  {
    "name": "아늑",
    "category": "이탈리아음식",
    "address": "경기 수원시 장안구 서부로2106번길 36-4 1층",
    "opening_hours": "11:00 - 21:00",
    "main_images": [
      "https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231210_80%2F1702176658239ea6DM_JPEG%2FGJS09200.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231210_19%2F1702176658246armz5_JPEG%2FGJS09202.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231210_20%2F1702176658129nurfz_JPEG%2FGJS09191.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220520_191%2F1653022005050EwCbB_JPEG%2F%25BF%25DC%25BA%25CE.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231210_165%2F1702176658231lLS5B_JPEG%2FGJS09194.jpg"
    ],
    "reviews": [
      ["Excellent!", "Best pasta ever!"],
      ["Good", "Nice atmosphere"],
    ],
  },
  {
    "name": "목구멍 율전점",
    "category": "육류, 고기요리",
    "address": "경기 수원시 장안구 화산로 233번길 46 1층",
    "opening_hours": "15:00 - 23:00",
    "main_images":[
      "https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230615_253%2F1686790793946ISiOc_JPEG%2F3%25B9%25F8.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230620_250%2F1687248423249aqaVJ_JPEG%2FIMG_E6265.jpeg.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230620_267%2F16872484231819MzVF_JPEG%2F%25B8%25F1%25B1%25B8%25B8%25DB_%25BA%25BB%25C1%25A1.jpeg.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230615_81%2F1686790793911Xxe8h_JPEG%2F2%25B9%25F8.jpg",
      "https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220708_3%2F1657263209253FbRbM_JPEG%2F%25B8%25DE%25C0%25CE1.jpg"
    ],
    "reviews":[
      ["soul1004hy",
      "첫번째사진(미박삼겹살4인분)\n두번째사진(모자를것 같아 2인분추가해서 함께 굽고있는 총 6인분삼겹살)\n세번째사진(갈비본살3인분)\n\n갈비본살 보단 삼겹살이 맛있습니다.\n(미나리는 예약하고 가서 받았습니다.)\n\n그리고 서빙하시는 분들이 외국분들이 많으신것 같았는데 머리색밝은 남자외국인분은 말을 좀 잘 못 배우신것 같아 오해의 소지가 생길 수 있는 말투였지만 여자외국인분이 고기도 넘 잘굽고 친절하셔서 감사했습니다.\n\n앗 그리고 한테이블당 3인분은 주문 해야한다고 하니 참고하시면 좋을것 같네요."
    ]]
  }
  // 다른 음식점 데이터...
];

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildDragHandle(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            controller: controller,
            children: <Widget>[
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Text("Nearby Restaurants", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30)),
                ),
              ),
              buildRestaurantList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDragHandle() => GestureDetector(
    onTap: togglePanel,
    child: Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  Widget buildRestaurantList() => Column(
    children: restaurants.map((restaurant) => RestaurantInfoWidget(
      name: restaurant['name'],
      category: restaurant['category'],
      address: restaurant['address'],
      openingHours: restaurant['opening_hours'],
      mainImages: List<String>.from(restaurant['main_images']),
      reviews: restaurant['reviews'],
    )).toList(),
  );
}
