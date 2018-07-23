import 'package:bride_story/pages/booking_page.dart';
import 'package:bride_story/pages/price_list_page.dart';
import 'package:bride_story/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'utils/constant.dart';
import 'pages/home_page.dart';
import 'pages/search_category_page.dart';
import 'package:fluro/fluro.dart';
import 'pages/search_country_page.dart';
import 'pages/search_city_page.dart';
import 'pages/result_search_page.dart';
import 'pages/vendor_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/project_list_page.dart';

// void main() => runApp(new MyApp());
void main() {
// Create the router.
  Router router = new Router();

  // Define our home page.
  router.define('/', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HomePageLayout();
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

  // Define our result search page.
  router.define('/searchResult', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ResultSearchPage();
  }));

  // Define our vendor page.
  router.define('/vendorPage', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new VendorPage();
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

  runApp(new MyApp(router: router));
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

class MyApp extends StatelessWidget {
  final Router router;
  MyApp({Key key, @required this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: lblTitleApplication,
      theme: new ThemeData(
        // primarySwatch: Colors.red,
        // primaryColor: kTelkomselRed,
        fontFamily: 'Roboto',
      ),
      home: HomePageLayout(),
      onGenerateRoute: router.generator,
    );
  }
}
