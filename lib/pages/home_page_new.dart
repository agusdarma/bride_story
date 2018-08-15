import 'dart:async';

import 'package:bride_story/pages/result_search_page_new.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageNew extends StatefulWidget {
  final Widget mapWidget;
  final GoogleMapController mapController;

  HomePageNew({Key key, this.mapWidget, this.mapController}) : super(key: key);

  @override
  _HomePageNewState createState() =>
      _HomePageNewState(mapController, mapWidget);
}

class _HomePageNewState extends State<HomePageNew> {
  _HomePageNewState(this.mapController, this.mapWidget);
  GoogleMapController mapController;
  Widget mapWidget;

  String displayedString = "";
  String displayedDate = "";
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;

  void initState() {
    super.initState();
    displayedString = "Jakarta";
    displayedDate = "Please Select Date Here";
  }

  @override
  Widget build(BuildContext context) {
    _navigateSearchButton(BuildContext context) {
      // Navigator.pushNamed(context, "/searchResult");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ResultSearchPageNew(
                  mapController: mapController,
                  mapWidget: mapWidget,
                )),
      );
    }

    String _convertBulan(int month) {
      String bulan = "";
      if (1 == month) {
        bulan = januari;
      } else if (2 == month) {
        bulan = februari;
      } else if (3 == month) {
        bulan = maret;
      } else if (4 == month) {
        bulan = april;
      } else if (5 == month) {
        bulan = mei;
      } else if (6 == month) {
        bulan = juni;
      } else if (7 == month) {
        bulan = juli;
      } else if (8 == month) {
        bulan = agustus;
      } else if (9 == month) {
        bulan = september;
      } else if (10 == month) {
        bulan = oktober;
      } else if (11 == month) {
        bulan = november;
      } else if (12 == month) {
        bulan = desember;
      }
      return bulan;
    }

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(2015, 8),
          lastDate: new DateTime(2101));
      if (picked != null) {
        setState(() {
          selectedDate = picked.millisecondsSinceEpoch;
          int year = new DateTime.fromMillisecondsSinceEpoch(selectedDate).year;
          int month =
              new DateTime.fromMillisecondsSinceEpoch(selectedDate).month;
          int day = new DateTime.fromMillisecondsSinceEpoch(selectedDate).day;
          displayedDate = day.toString() +
              ' ' +
              _convertBulan(month) +
              ' ' +
              year.toString();
        });
      }
    }

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
            onTap: () {
              _selectDate(context);
            },
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
                    child: new Text(displayedDate,
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
            onTap: () {
              _navigateSearchButton(context);
            },
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
                  // mapWidget,
                ],
              ),
            )));
  }
}
