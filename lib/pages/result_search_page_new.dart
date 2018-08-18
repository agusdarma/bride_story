import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/result_search_model.dart';
import 'package:bride_story/models/venue_model.dart';
import 'package:bride_story/pages/vendor_page_new.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultSearchPageNew extends StatefulWidget {
  final GoogleMapController mapController;
  final GoogleMapOverlayController overlayController;
  final List<PageNew> allPages;

  ResultSearchPageNew(
      {Key key, this.mapController, this.overlayController, this.allPages})
      : super(key: key);

  @override
  _ResultSearchPageNewState createState() =>
      _ResultSearchPageNewState(mapController, overlayController, allPages);
}

class _ResultSearchPageNewState extends State<ResultSearchPageNew> {
  _ResultSearchPageNewState(
      this.mapController, this.overlayController, this.allPages);
  GoogleMapController mapController;
  final formatter = new NumberFormat("#,###");   
  GoogleMapOverlayController overlayController;
  List<PageNew> allPages;

  String text = "Loading";
  List<ResultSearchModel> listResultData = new List<ResultSearchModel>();
  List<VenueModel> listVenueData = new List<VenueModel>();
  FilterParam filterParamNew;
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;
  String displayedDate = "";

  void _populateResultData(List<dynamic> listVenue) {
    for (var items in listVenue) {
      Map venue = items; //store each map
      String linkImageVenue = venue['linkImageVenue'];
      String titleVenue = venue['titleVenue'];
      String addressVenue = venue['addressVenue'];
      String capacityVisitor = venue['capacityVisitor'];
      String capacityParkir = venue['capacityParkir'];
      String luasBangunan = venue['luasBangunan'];
      String luasTanah = venue['luasTanah'];
      String hargaVenue = formatter.format(int.parse(venue['hargaVenue']));         
      int idCity = venue['idCity'];
      String locationVenue = venue['locationVenue'];
      listVenueData.add(
        new VenueModel(
          linkImageVenue,
          titleVenue,
          addressVenue,
          capacityVisitor,
          capacityParkir,
          luasBangunan,
          luasTanah,
          hargaVenue,
          idCity,
          locationVenue)
          );
    }

    // listResultData.add(new ResultSearchModel(
    //     "assets/images/1.jpg",
    //     "Jova Musique",
    //     "32",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/2.jpg",
    //     "Port Love Creative Studio",
    //     "16",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/3.jpg",
    //     "Port Love Creative Studio 2",
    //     "17",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/3.jpg",
    //     "Port Love Creative Studio 2",
    //     "17",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/3.jpg",
    //     "Port Love Creative Studio 2",
    //     "17",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/3.jpg",
    //     "Port Love Creative Studio 2",
    //     "17",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    // listResultData.add(new ResultSearchModel(
    //     "assets/images/3.jpg",
    //     "Port Love Creative Studio 2",
    //     "17",
    //     filterParamNew.categoryName,
    //     filterParamNew.cityName,
    //     "assets/images/1.jpg",
    //     "assets/images/2.jpg",
    //     "assets/images/3.jpg",
    //     "assets/images/4.jpg"));
    print(listVenueData.length);
  }

  Future<String> _getFilterParam(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = (prefs.getString(key) ?? "");
    print("get from shared Preferenced " + json);
    return json;
  }

  @override
  void initState() {
    super.initState();
    HttpServices http = new HttpServices();
    http.getAllVenue().then((List<dynamic> listVenue) {
      setState(() {
        // _generateCarouselWidget(listVenue);
        _populateResultData(listVenue);
      });
    });

    setState(() {
      displayedDate = '28 Agustus 2018';
      _getFilterParam(keyFilterParam).then((result) {
        setState(() {
          updateSubtitle(result);
        });
      });
    });
  }

  Future updateSubtitle(String json) async {
    // print(json);
    // await new Future.delayed(const Duration(seconds: 2));
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(json);
    filterParamNew = new FilterParam.fromJson(filterParamMap);
    setState(() {
      text = "Search result for " +
          filterParamNew.categoryName +
          " in " +
          filterParamNew.cityName +
          " ," +
          filterParamNew.countryName;
      // _populateResultData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text('Jakarta',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text('428 available venue',
              style: TextStyle(
                fontSize: 14.0,
              )),
        )
      ],
    );

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

    _navigateVendorPage(BuildContext context) {
      // Navigator.pushNamed(context, "/vendorPage");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VendorPageNew(
                  mapController: mapController,
                  overlayController: overlayController,
                  allPages: allPages,
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

    var selectedDateView = Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              // _navigateAndDisplaySelection(context);
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
                  Text('Changes',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          )),
    );

    Widget imageVenue(BuildContext context, int index) {
      return new Container(
          margin: EdgeInsets.only(right: 5.0),
          width: 140.0,
          height: 200.0,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new AssetImage(
                    'assets/images/'+listVenueData.elementAt(index).linkImageVenue),
              )));
    }

    Widget descVenue(BuildContext context, int index) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 4.0, bottom: 5.0),
              child: Text(listVenueData.elementAt(index).titleVenue,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.store),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                    child: Text(listVenueData.elementAt(index).addressVenue,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.view_module),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                    child: Text(listVenueData.elementAt(index).capacityVisitor,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.local_parking),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                    child: Text(listVenueData.elementAt(index).capacityParkir,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.terrain),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                    child: Text(listVenueData.elementAt(index).luasBangunan,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.terrain),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                    child: Text(listVenueData.elementAt(index).luasTanah,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        )),
                  ),
                  flex: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 4.0, top: 30.0, right: 10.0),
                  child: Text('Rp.' +listVenueData.elementAt(index).hargaVenue,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      )),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget content(BuildContext context, int index) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 9.0, right: 9.0),
        margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
        child: Material(
            elevation: 4.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            child: InkWell(
              onTap: () {
                _navigateVendorPage(context);
              },
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    imageVenue(context, index),
                    descVenue(context, index),
                  ],
                ),
              ),
            )),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          title: header,
        ),
        body: Column(
          children: <Widget>[
            selectedDateView,
            new Expanded(
              child: new Container(
                child: new ListView.builder(
                  itemCount: listVenueData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return content(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
