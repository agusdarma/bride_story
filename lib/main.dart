import 'package:flutter/material.dart';
import 'utils/constant.dart';
import 'pages/home_page.dart';
import 'pages/search_category_page.dart';
import 'package:fluro/fluro.dart';
import 'pages/search_country_page.dart';
import 'pages/search_city_page.dart';
import 'pages/result_search_page.dart';
import 'pages/vendor_page.dart';

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
  
  runApp(new MyApp(router: router));
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
