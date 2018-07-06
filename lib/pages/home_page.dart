import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelStyle: TextStyle(
              // fontFamily: 'Roboto',
              fontSize: 16.0,
            ),
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Category"),
            ],
          ),
          title: new Text("Bride Story"),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            Icon(Icons.favorite),
          ],
        ),
      ),
    );
  }
}

class CityButton extends StatefulWidget {
  @override
  _CityButtonState createState() => _CityButtonState();
}

class _CityButtonState extends State<CityButton> {
  int counter = 0;
  List<String> strings = ["Flutter", "Is", "Awesome"];
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "Jakarta";
  }

  void onPressed() {
    setState(() {
      displayedString = strings[counter];
      counter = counter < 2 ? counter + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: new RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: new Text(displayedString,
                        style: TextStyle(
                          // fontFamily: 'Roboto',
                          fontSize: 15.0,
                        )),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              color: Colors.white,
              onPressed: onPressed),
        )
      ],
    );
  }
}

class CountryButton extends StatefulWidget {
  @override
  _CountryButtonState createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton> {
  int counter = 0;
  List<String> strings = ["Flutter", "Is", "Awesome"];
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "Indonesia";
  }

  void onPressed() {
    setState(() {
      displayedString = strings[counter];
      counter = counter < 2 ? counter + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: new RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: new Text(displayedString,
                        style: TextStyle(
                          // fontFamily: 'Roboto',
                          fontSize: 15.0,
                        )),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              color: Colors.white,
              onPressed: onPressed),
        )
      ],
    );
  }
}

class CategoryButton extends StatefulWidget {
  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  // SharedPreferences sharedPreferences;
  int counter = 0;
  List<String> strings = ["Flutter", "Is", "Awesome"];
  String displayedString = "";

  void initState() {
    super.initState();
    // sharedPreferences = await SharedPreferences.getInstance();  
    displayedString = "All Categories";
    // get dari shared preference
    // String pref = sharedPreferences.getString(keyFilterParam);   
    // print(pref);  
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: new RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: new Text(displayedString,
                        style: TextStyle(
                          // fontFamily: 'Roboto',
                          fontSize: 15.0,
                        )),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              color: Colors.white,
              // onPressed: onPressed
              onPressed: (){
                Navigator.pushNamed(context, '/searchCategory');
                },
              ),
        )
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  static String tag = 'homePage';
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget carousel = new Carousel(
      boxFit: BoxFit.cover,
      images: [
        new AssetImage('assets/images/1.jpg'),
        new AssetImage('assets/images/2.jpg'),
        new AssetImage('assets/images/3.jpg'),
        new AssetImage('assets/images/4.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(seconds: 1),
    );

    Widget banner = new Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.amber.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'Top Venue',
          style: TextStyle(
            // fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            // color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    Widget txtSearch = new Container(
      padding: EdgeInsets.only(left: 10.0),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(1.0),
      // color: Colors.white,
      height: 30.0,
      width: screenWidth,
      child: new Text("Search Vendor Based On:",
          style: TextStyle(
            // fontFamily: 'Roboto',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          )),
    );

    Widget txtCategory = new Container(
      padding: EdgeInsets.only(left: 10.0),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(1.0),
      // color: Colors.white,
      height: 30.0,
      width: screenWidth,
      child: new Text("Category:",
          style: TextStyle(
            // fontFamily: 'Roboto',
            fontSize: 14.0,
          )),
    );

    Widget txtLocation = new Container(
      padding: EdgeInsets.only(left: 10.0),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(1.0),
      // color: Colors.white,
      height: 30.0,
      width: screenWidth,
      child: new Text("Location:",
          style: TextStyle(
            // fontFamily: 'Roboto',
            fontSize: 14.0,
          )),
    );

    final searchButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: screenWidth,
          height: 35.0,
          onPressed: () {
            Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.lightBlueAccent,
          child: Text('Search Vendors',
              style: TextStyle(
                // fontFamily: 'Roboto',
                fontSize: 14.0,
              )),
        ),
      ),
    );

    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Container(
            // padding: const EdgeInsets.all(2.0),
            height: screenHeight / 5,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: new Stack(
                children: [
                  carousel,
                  banner,
                ],
              ),
            ),
          ),
          new Container(
              color: Colors.grey[300],
              height: screenHeight,
              child: new Column(
                children: <Widget>[
                  txtSearch,
                  Divider(color: Colors.black, height: 1.0),
                  txtCategory,
                  CategoryButton(),
                  txtLocation,
                  CountryButton(),
                  Divider(color: Colors.black, height: 1.0),
                  CityButton(),
                  Divider(),
                  searchButton,
                ],
              ))
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
