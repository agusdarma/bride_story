import 'dart:async';
import 'dart:convert';



import 'package:bride_story/pages/screens/ProductList/index.dart';

import '../plugins/components/Buttons/buyNowButton.dart';

import '../plugins/components/trending.dart';

import '../theme/style.dart';

import '../plugins/components/CircleImage.dart';
import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/pages/result_search_page_new.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageNewBar extends StatefulWidget {
  final List<PageNew> allPages;

  HomePageNewBar({Key key, this.allPages}) : super(key: key);

  @override
  _HomePageNewBarState createState() => _HomePageNewBarState(allPages);
}

class _HomePageNewBarState extends State<HomePageNewBar> {
  _HomePageNewBarState(this.allPages);
  List<PageNew> allPages;

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
                  fontSize: 28.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            content: new Text(message,
                style: TextStyle(
                  fontSize: 18.0,
                  // color: Colors.red,
                  // fontWeight: FontWeight.bold,
                )),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close",
                    style: TextStyle(
                      fontSize: 18.0,
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
            builder: (context) => new ProductList(
                  allPages: allPages,
                  parameter: parameter,
                )),
      );
    }

//    _navigateSearchButton(BuildContext context) {
//      Navigator.push(
//        context,
//        new MaterialPageRoute(
//            builder: (context) => new ResultSearchPageNew(
//              allPages: allPages,
//              parameter: parameter,
//            )),
//      );
//    }

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
                  Icon(Icons.search,color: Colors.blue,),
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: new Text(displayedString,
                        style: TextStyle(
                          fontSize: 14.0,
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
                  Icon(Icons.date_range,color: Colors.blue,),
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: new Text(displayedDate,
                        style: TextStyle(
                          fontSize: 14.0,
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

//    return new SingleChildScrollView(
//      padding: const EdgeInsets.only(
//          left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
//      child: new Column(
//        children: <Widget>[
//          logoView,
//          new Card(
//              child: new SingleChildScrollView(
//                scrollDirection: Axis.horizontal,
//                child: new GestureDetector(
//                  onTap: () {
//                    Navigator.of(context).pushNamed('/shopmen');
//                  },
//                  child: new Row(children: <Widget>[
//                    new CircleImage(
//                      picture: new AssetImage("assets/images/circle1.png"),
//                      text: 'MEN',
//                    ),
//                    new CircleImage(
//                      picture: new AssetImage("assets/images/circle2.png"),
//                      text: 'WOMEN',
//                    ),
//                    new CircleImage(
//                      picture: new AssetImage("assets/images/circle3.png"),
//                      text: 'KIDS',
//                    ),
//                    new CircleImage(
//                      picture: new AssetImage("assets/images/circle4.png"),
//                      text: 'HOME',
//                    ),
//                    new CircleImage(
//                      picture: new AssetImage("assets/images/circle5.png"),
//                      text: 'EOS',
//                    ),
//                  ]),
//                ),
//              )),
//          searchCitiesView,
//          searchDateView,
//          buttonSearchView,
//          // mapWidget,
//        ],
//      ),
//    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: new Text(
          "LookUp",
          style: textStylew600,
        ),
        actions: <Widget>[
//          new Icon(
//            Icons.search,
//            color: Colors.black,
//          ),
        ],
      ),
      body: new ListView(
        padding: const EdgeInsets.only(
            left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
          children: <Widget>[
//            new Card(
//                child: new SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: new GestureDetector(
//                    onTap: () {
//                      Navigator.of(context).pushNamed('/shopmen');
//                    },
//                    child: new Row(children: <Widget>[
//                      new CircleImage(
//                        picture: new AssetImage("assets/images/circle1.png"),
//                        text: 'MEN',
//                      ),
//                      new CircleImage(
//                        picture: new AssetImage("assets/images/circle2.png"),
//                        text: 'WOMEN',
//                      ),
//                      new CircleImage(
//                        picture: new AssetImage("assets/images/circle3.png"),
//                        text: 'KIDS',
//                      ),
//                      new CircleImage(
//                        picture: new AssetImage("assets/images/circle4.png"),
//                        text: 'HOME',
//                      ),
//                      new CircleImage(
//                        picture: new AssetImage("assets/images/circle5.png"),
//                        text: 'EOS',
//                      ),
//                    ]),
//                  ),
//                )),
            searchCitiesView,
            searchDateView,
            buttonSearchView,
//            new Card(
//              child: new Padding(
//                  padding: const EdgeInsets.only(
//                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
//                  child: new GestureDetector(
//                      onTap: () {
//                        Navigator.of(context).pushNamed('/product');
//                      },
//                      child: new Image(
//                        image: new ExactAssetImage("assets/images/bannersale.png"),
//                      ))),
//            ),
//            new Card(
//                child: new Column(
//                  children: [
//                    new Container(
//                      margin: const EdgeInsets.only(
//                          top: 0.0, bottom: 0.0, right: 5.0, left: 0.0),
//                      padding: const EdgeInsets.only(
//                          top: 0.0, bottom: 0.0, left: 0.0, right: 2.0),
//                      height: 40.0,
//                      color: Colors.white,
//                      child: new ListTile(
//                        title: new Text(
//                          "Trending Now",
//                          style: textStyleheader,
//                        ),
//                      ),
//                    ),
//                    new SingleChildScrollView(
//                      scrollDirection: Axis.horizontal,
//                      child: new GestureDetector(
//                        onTap: () {
//                          Navigator.of(context).pushNamed('/productList');
//                        },
//                        child: new Row(
//                          children: <Widget>[
//                            new Column(children: <Widget>[
//                              new Trending(
//                                picture: new ExactAssetImage("assets/images/women.png"),
//                              ),
//                              new Text(
//                                "The Grunge Collection!",
//                                style: textStylesubTitle,
//                              ),
//                              new Padding(
//                                padding: const EdgeInsets.only(
//                                    left: 0.0, top: 5.0, bottom: 10.0, right: 0.0),
//                                child: new Text(
//                                  "Born For the Road",
//                                  style: textStylesubTitleLight,
//                                ),
//                              ),
//                            ]),
//                            new Column(children: <Widget>[
//                              new Trending(
//                                picture: new ExactAssetImage("assets/images/b4.png"),
//                              ),
//                              new Text(
//                                "On Point!",
//                                style: textStylesubTitle,
//                              ),
//                              new Padding(
//                                padding: const EdgeInsets.only(
//                                    left: 0.0, top: 5.0, bottom: 10.0, right: 0.0),
//                                child: new Text(
//                                  "Premium Bags That Steal The Spotlight",
//                                  style: textStylesubTitleLight,
//                                ),
//                              ),
//                            ]),
//                            new Column(children: <Widget>[
//                              new Trending(
//                                picture: new ExactAssetImage("assets/images/b3.png"),
//                              ),
//                              new Text(
//                                "A Fresh Edge To Everyday Wear ",
//                                style: textStylesubTitle,
//                              ),
//                              new Padding(
//                                padding: const EdgeInsets.only(
//                                    left: 0.0, top: 5.0, bottom: 10.0, right: 0.0),
//                                child: new Text(
//                                  "Printed Tees",
//                                  style: textStylesubTitleLight,
//                                ),
//                              ),
//                            ]),
//                            new Column(children: <Widget>[
//                              new Trending(
//                                picture: new ExactAssetImage("assets/images/women.png"),
//                              ),
//                              new Text(
//                                "Up to 50% Off",
//                                style: textStylesubTitle,
//                              ),
//                              new Padding(
//                                padding: const EdgeInsets.only(
//                                    left: 0.0, top: 5.0, bottom: 10.0, right: 0.0),
//                                child: new Text(
//                                  "Born For the Road",
//                                  style: textStylesubTitleLight,
//                                ),
//                              ),
//                            ]),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                )),
//            new Column(
//              children: <Widget>[
//                new Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          left: 6.0, top: 5.0, bottom: 8.0, right: 4.0),
//                      child: new Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Text(
//                            ' United Colors of Benetton ',
//                            style: textStylesubTitle,
//                          ),
//                          new Text(
//                            ' United Colors of Benetton Men Coral red Solid  ',
//                            style: textStylesubTitleLighter,
//                          ),
//                          new Text(
//                            ' Polo Collar T-Shirt',
//                            style: textStylesubTitleLighter,
//                          ),
//                        ],
//                      ),
//                    ),
//                    new BuynowButton(
//                      text: 'BUY NOW',
//                    )
//                  ],
//                ),
//              ],
//            ),
//            new Column(
//              children: <Widget>[
//                new Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
//                      child: new Text('\$900'),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
//                      child: new Text(
//                        "\$1,499",
//                        style: new TextStyle(
//                          color: Colors.grey,
//                          decoration: TextDecoration.lineThrough,
//                          fontStyle: FontStyle.italic,
//                        ),
//                      ),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
//                      child: new Text(
//                        '40%off',
//                        style: new TextStyle(
//                          color: gotobagColor,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            )
          ]),
      );
  }
}
