import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/pages/home_nav_bar.dart';
import 'package:bride_story/pages/my_booking_nav_bar.dart';
import 'package:bride_story/pages/result_search_page_new.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageNew extends StatefulWidget {
  final List<PageNew> allPages;

  HomePageNew({Key key, this.allPages}) : super(key: key);

  @override
  _HomePageNewState createState() => _HomePageNewState(allPages);
}

class _HomePageNewState extends State<HomePageNew> {
  _HomePageNewState(this.allPages);  
  List<PageNew> allPages;  
  // List<Widget> _children = [HomeWidget(Colors.yellow), new Text('1')];
  List<Widget> _children = [];
  int _currentIndex = 0;

  String displayedString = "";
  String displayedDate = "";
  int selectedDate;
  FilterParam parameter;

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

  Future<String> getLoginDataSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = "";
    json = (prefs.getString(key) ?? "");
    print("getLoginDataSharedPreferences " + json);
    return json;
  }

  void initState() {
    super.initState();
    displayedString = "Jakarta";
    displayedDate = "Please Select Date Here";
    parameter = new FilterParam('', 0, '', 0, 'Jakarta', 1, 0); 
    _children.add(HomePageNewBar(allPages: allPages,));
    _children.add(MyBookingPage());   
  }

  @override
  Widget build(BuildContext context) {
    void _showDialogError(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: new Text("Warning",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            content: new Text(message,
                style: TextStyle(
                  fontSize: 16.0,
                  // color: Colors.red,
                  // fontWeight: FontWeight.bold,
                )),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close",
                    style: TextStyle(
                      fontSize: 16.0,
                      // color: Colors.red,
                      // fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _navigateSearchButton(BuildContext context) {      
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ResultSearchPageNew(                  
                  allPages: allPages,
                  parameter: parameter,
                )),
      );
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
          parameter.bookingDate = selectedDate;
          // print(parameter);
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
          const JsonDecoder decoder = const JsonDecoder();
          Map filterParamMap = decoder.convert(result);
          var filterParamNew = new FilterParam.fromJson(filterParamMap);
          displayedString = filterParamNew.cityName;
          parameter.cityId = filterParamNew.cityId;
          parameter.cityName = filterParamNew.cityName;          
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
                        fontSize: 16.0,
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
              if (parameter.bookingDate == 0) {
                _showDialogError("Silahkan pilih tanggal booking.");
              } else {
                _navigateSearchButton(context);
              }
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
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          )),
    );

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
        print(_currentIndex);
      });
    }

    Widget home = new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  logoView,
                  searchCitiesView,
                  searchDateView,
                  buttonSearchView,
                  // mapWidget,
                ],
              ),
            );

    return SafeArea(
        child: new Scaffold(
            backgroundColor: Colors.cyan[100],
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex:
                  _currentIndex, // this will be set when a new tab is tapped
              items: 
              // itemsBottom,
              [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.mail),
                  title: new Text('My Booking'),
                ),
              ],
            ),
            // body: new SingleChildScrollView(
            //   child: new Column(
            //     children: <Widget>[
            //       logoView,
            //       searchCitiesView,
            //       searchDateView,
            //       buttonSearchView,
            //       // mapWidget,
            //     ],
            //   ),
            // )
            body: _children[_currentIndex]
            ));
  }
}
