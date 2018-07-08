import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
          // title: new Text("Bride Story"),
          leading: const Icon(Icons.search),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Search Vendors, Articles Here...."
            ),
          ),
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
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "Jakarta";
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/searchCity');
    if (result != null) {
      setState(() {
        displayedString = result;
      });
    }
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
                        fontSize: 15.0,
                      )),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
            color: Colors.white,
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
          ),
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
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "Indonesia";
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/searchCountry');
    if (result != null) {
      setState(() {
        displayedString = result;
      });
    }
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
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
          ),
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
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "All Categories";
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/searchCategory');
    if (result != null) {
      setState(() {
        displayedString = result;
      });
    }
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
            onPressed: () {
              _navigateAndDisplaySelection(context);
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
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
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
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          )),
    );

    _navigateSearchButton(BuildContext context){
    Navigator.pushNamed(context, "/searchResult");
  }

    final searchButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: screenWidth-32,
          height: 35.0,
          onPressed: () {
            _navigateSearchButton(context);
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
