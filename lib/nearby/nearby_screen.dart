import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mealmatch/global/restaurant_detail_screen.dart';
import 'package:mealmatch/nearby/widgets/panel_widget.dart';
import 'package:mealmatch/search/search_screen.dart';
import 'package:mealmatch/nearby/widgets/nearby_places_widget.dart';
import 'package:mealmatch/screen/widgets/track_location_button.dart';
import 'package:mealmatch/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../global/widgets/search_widget.dart';
import '../models/restaurant.dart';
import '../services/data_manager.dart';

class NearbyPage extends StatefulWidget {
  final int currentIndex;
  const NearbyPage({super.key, required this.currentIndex});

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  final panelController = PanelController();
  Timer? _debounceTimer;

  FocusScopeNode focusNode = FocusScopeNode();
  static const start_latitude = 37.2939;
  static const start_longitude = 126.9756;
  //late Position position;
  double latitude = 37.2939;
  double longitude = 126.9756;
  double _slidingPosition = 0;
  double _buttonOpactity = 1.0;
  bool _showButton = false;
  List<Restaurant> _restaurantsInRange = [];

  //NCameraPosition? lastCameraPosition; //마지막 카메라 위치를 저장할 변수

  @override
  bool get wantKeepAlive => true;

  _setCurrentLocation() async {
    LocationPermission permission = await MapPermissionUtils
        .checkAndRequestLocationPermission();
    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      NaverMapController controller = await mapControllerCompleter.future;
    }
  }

  void _addMarker(double lat, double lon, Restaurant restaurant) async {
    NaverMapController controller = await mapControllerCompleter.future;
    final marker = NMarker(
      position: NLatLng(lat, lon),
      //id: name,
      id: restaurant.koName,
    );
    marker.setOnTapListener((overlay) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RestaurantDetailPage(restaurant: restaurant),)
        );
    });
    controller.addOverlay(marker);
  }

  Future<void> _fetchRestaurants() async {
    NaverMapController controller = await mapControllerCompleter.future;
    NLatLngBounds bounds = await controller.getContentBounds();
    final dataManager = Provider.of<DataManager>(context, listen: false);
    List<Restaurant?> restaurantsInRange = dataManager.restaurants.where((restaurant) {
      if (restaurant == null) return false;
      return (restaurant.latitude >= bounds.southWest.latitude &&
          restaurant.latitude <= bounds.northEast.latitude &&
          restaurant.longitude >= bounds.southWest.longitude &&
          restaurant.longitude <= bounds.northEast.longitude);
    }).toList();

    controller.clearOverlays();
    _restaurantsInRange = restaurantsInRange.whereType<Restaurant>().toList();

    for (var restaurant in restaurantsInRange) {
      if (restaurant != null) {
        _addMarker(restaurant.latitude, restaurant.longitude, restaurant);
      }
    }
  }

  void _onCameraChanged(){
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    setState(() {
      _showButton = true;
    });
    _debounceTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showButton = false;
      });
    });
  }

  @override
  void initState() {
    _setCurrentLocation();
    super.initState();
    Provider.of<DataManager>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 원래 상태 유지 by AutomaticKeepAliveClientMixin
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.65;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          NaverMap(
            options: const NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: NLatLng(start_latitude, start_longitude),
                zoom: 15
              ),
              indoorEnable: false,
              locationButtonEnable: true,
              consumeSymbolTapEvents: true,
              logoClickEnable: false,
            ),
            onMapReady: (controller) async{
              mapControllerCompleter.complete(controller);
              await _fetchRestaurants();
            },
            onCameraChange: (reason, animated) async{
              _onCameraChanged();
            },
          ),
          /*Positioned(
            bottom: MediaQuery.of(context).size.height * 0.06,
            right: 8,
            child: TrackLocationButton(onTap: () {}),
          ),*/

          SlidingUpPanel(
            backdropEnabled: true,
            backdropOpacity: 0.3,
            controller: panelController,
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
              panelController: panelController,
              restaurants: _restaurantsInRange,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(
                isShowCancel: false,
                loading: false,
                readOnly: true,
                onCancelTap: () {},
                controller: _searchController,
                isOutlined: PanelPositionUtils.isSlidingPanelOpen(_slidingPosition) ? true : false,
                focusNode: focusNode,
                onTapOutSide: (pointerDownEvent){
                  focusNode.unfocus();
                },
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    if(focusNode.hasFocus){
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 100),
                        )
                      );
                    }
                  },);
                },
              ),

              NearbyPlacesWidget(
                onComplete: (value) {},
                onPlaceClickListner: (nearbyPlaces) {},
              ),

              //ChangeMapTypeButton(onTap: () {})
              if (_showButton)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _fetchRestaurants();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('현 지도에서 검색'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /*Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TrackLocationButton(onTap: () {})
            ],
          )*/
        ],
      ),
    );
  }
}
