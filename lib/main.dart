import 'package:flutter/material.dart';
import 'utils/constant.dart';
import 'pages/home_page.dart';
import 'pages/search_category_page.dart';
import 'package:fluro/fluro.dart';

// void main() => runApp(new MyApp());
void main() {
// Create the router.
  Router router = new Router();

  // Define our search category page.
  router.define('/searchCategory', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SearchCategoryPage();
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
