import 'package:flutter/material.dart';

class HomePageNew extends StatefulWidget {
  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  String displayedString = "";

  void initState() {
    super.initState();
    displayedString = "Jakarta";
  }

  @override
  Widget build(BuildContext context) {
    _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.pushNamed(context, '/searchCity');
      if (result != null) {
        setState(() {
          displayedString = result;
          // print(result);
        });
      }
    }

    var logoView = Container(
      // decoration: linearGradient,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      margin: EdgeInsets.only(top: 10.0, bottom: 12.0),
      child: Material(
          // elevation: 4.0,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text('Bride Customer',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          )),
    );

    var searchCitiesView = Container(
      // decoration: linearGradient,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      margin: EdgeInsets.only(top: 10.0, bottom: 12.0),
      child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              _navigateAndDisplaySelection(context);
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search),
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: new Text(displayedString,
                        style: TextStyle(
                          fontSize: 15.0,
                        )),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          )),
    );

    var searchDateView = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.date_range),
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: new Text('Please Select Date Here',
                        style: TextStyle(
                          fontSize: 15.0,
                        )),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          )),
    );

    var buttonSearchView = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      child: Material(
          elevation: 4.0,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  new Text('Search',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          )),
    );

    return SafeArea(
        child: new Scaffold(
            backgroundColor: Colors.cyan[100],
            body: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  logoView,
                  searchCitiesView,
                  searchDateView,
                  buttonSearchView,
                ],
              ),
            )));
  }
}
