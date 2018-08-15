import 'package:bride_story/pages/booking_page.dart';
import 'package:bride_story/pages/google_maps_detail_new.dart';
import 'package:bride_story/pages/home_page_new.dart';

import 'package:bride_story/pages/price_list_page.dart';
import 'package:bride_story/pages/result_search_page_new.dart';
import 'package:bride_story/pages/vendor_page_new.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'utils/constant.dart';
import 'pages/search_category_page.dart';
import 'package:fluro/fluro.dart';
import 'pages/search_country_page.dart';
import 'pages/search_city_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/project_list_page.dart';

// void main() => runApp(new MyApp());
void main() {
// Create the router.
  Router router = new Router();

  // // Define our home page.
  // router.define('/', handler: new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //   return new HomePageLayout();
  // }));

  // Define our home page.
  router.define('/', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HomePageNew();
  }));

  // Define our search category page.
  router.define('/searchCategory', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SearchCategoryPage();
  }));

  // Define our search country page.
  router.define('/searchCountry', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SearchCountryPage();
  }));

  // Define our search city page.
  router.define('/searchCity', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SearchCityPage();
  }));

  // // Define our result search page.
  // router.define('/searchResult', handler: new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //   return new ResultSearchPage();
  // }));

  // Define our result search page new.
  router.define('/searchResult', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ResultSearchPageNew();
  }));

  // // Define our vendor page.
  // router.define('/vendorPage', handler: new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //   return new VendorPage();
  // }));

  // Define our vendor page new.
  router.define('/vendorPage', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new VendorPageNew();
  }));

  // Define our price list page.
  router.define('/priceListPage', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PriceListPage();
  }));

  // Define our project list page.
  router.define('/projectListPage', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ProjectListPage();
  }));

  // Define our booking page.
  router.define('/bookingPage', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new BookingPage();
  }));

  // // Define our web view page.
  // router.define('/webViewPage', handler: new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //   return new WebviewPage(url: null,);
  // }));

  initSharedPreferences();
  // GoogleMapController.init();
  // final List<NavigatorObserver> observers = <NavigatorObserver>[];
  // for (Page p in _allPages) {
  //   observers.add(p.controller.overlayController);
  // }
  GoogleMapController.init();
  // final GoogleMapOverlayController controller =
  //     GoogleMapOverlayController.fromSize(width: 300.0, height: 200.0);
  // final GoogleMapOverlayController controller =
  //     GoogleMapOverlayController.fromSize(
  //   width: 400.0,
  //   height: 500.0,
  //   options: GoogleMapOptions(
  //     cameraPosition: const CameraPosition(
  //       bearing: 270.0,
  //       target: LatLng(-6.1541491, 106.8893441),
  //       tilt: 10.0,
  //       zoom: 16.0,
  //     ),
  //     trackCameraPosition: true,
  //     scrollGesturesEnabled: true
  //   ),
  // );
  // final Widget mapWidget = GoogleMapOverlay(controller: controller);
  runApp(new MyApp(
    router: router,
    // mapWidget: mapWidget,
    // mapController: controller.mapController,
    // navigatorObserver: controller.overlayController,
  ));
}

void initSharedPreferences() {
  print("init shared preferences running");
  String filterParamJson =
      '{"categoryName":"All Categories","countryName":"Indonesia","cityName":"Jakarta"}';
  saveCategoryNameInSharedPreferences(filterParamJson, keyFilterParam);
}

void saveCategoryNameInSharedPreferences(
    String categoryName, String key) async {
  print("aaaa");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, categoryName);
}

// final List<PageNew> _allPages = <PageNew>[
//   GoogleMapsDetailNew(),
//   // MoveCameraPage(),
//   // PlaceMarkerPage(),
// ];

class MyApp extends StatelessWidget {
  final Router router;
  // final Widget mapWidget;
  // final GoogleMapController mapController;
  // final NavigatorObserver navigatorObserver;

  MyApp({
    Key key,
    @required this.router,
    // this.mapWidget,
    // this.mapController,
    // this.navigatorObserver
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<PageNew> _allPages = <PageNew>[
      GoogleMapsDetailNew(),     
    ];
    final List<NavigatorObserver> observers = <NavigatorObserver>[];
    for (PageNew p in _allPages) {
      observers.add(p.controller.overlayController);
    }
    final GoogleMapOverlayController controller =
        GoogleMapOverlayController.fromSize(
      width: 300.0,
      height: 200.0,
      options: GoogleMapOptions(
          cameraPosition: const CameraPosition(
            bearing: 270.0,
            target: LatLng(-6.1541491, 106.8893441),
            tilt: 10.0,
            zoom: 16.0,
          ),
          trackCameraPosition: true,
          scrollGesturesEnabled: true),
    );
    final Widget mapWidget = GoogleMapOverlay(controller: controller);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: lblTitleApplication,
      theme: new ThemeData(
        // primarySwatch: Colors.red,
        // primaryColor: kTelkomselRed,
        fontFamily: 'Roboto',
      ),
      home: HomePageNew(
        mapWidget: mapWidget,
        mapController: controller.mapController,
      ),
      onGenerateRoute: router.generator,
      // navigatorObservers: <NavigatorObserver>[controller.overlayController],
      navigatorObservers: observers,
    );
  }
}
