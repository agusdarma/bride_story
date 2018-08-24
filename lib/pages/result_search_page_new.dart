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
  final FilterParam parameter;

  ResultSearchPageNew(
      {Key key,
      this.mapController,
      this.overlayController,
      this.allPages,
      this.parameter})
      : super(key: key);

  @override
  _ResultSearchPageNewState createState() => _ResultSearchPageNewState(
      mapController, overlayController, allPages, parameter);
}

class _ResultSearchPageNewState extends State<ResultSearchPageNew> {
  _ResultSearchPageNewState(this.mapController, this.overlayController,
      this.allPages, this.parameter);
  GoogleMapController mapController;
  final formatter = new NumberFormat("#,###");
  GoogleMapOverlayController overlayController;
  List<PageNew> allPages;
  FilterParam parameter;

  String text = "Loading";
  List<ResultSearchModel> listResultData = new List<ResultSearchModel>();
  List<VenueModel> listVenueData = new List<VenueModel>();
  FilterParam filterParamNew;
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;
  String displayedDate = "";
  String countSearch = "0";

  void _populateResultData(List<dynamic> listVenue) {
    for (var items in listVenue) {
      Map venue = items; //store each map
      Map venue2 = venue['venue'];
      List<dynamic> listBookingDate = venue['listBookingDates'];
      int isDay;
      int isNight;
      int isDayFlag;
      int isNightFlag;
      int bookingDateVal;
      for (var bookingDate in listBookingDate) {
        if (bookingDate['bookingDate'] == parameter.bookingDate) {
          isDay = bookingDate['isDay'];
          isNight = bookingDate['isNight'];
          isDayFlag = bookingDate['isDay'];
          isNightFlag = bookingDate['isNight'];
          bookingDateVal = bookingDate['bookingDate'];
        } else {
          isDay = bookingDate['isDay'];
          isNight = bookingDate['isNight'];
          // isDayFlag = bookingDate['isDay'];
          // isNightFlag = bookingDate['isNight'];
          bookingDateVal = bookingDate['bookingDate'];
        }
      }
      int id = venue2['id'];
      String linkImageVenue = venue2['linkImageVenue'];
      String titleVenue = venue2['titleVenue'];
      String addressVenue = venue2['addressVenue'];
      String capacityVisitor = venue2['capacityVisitor'];
      String capacityParkir = venue2['capacityParkir'];
      String luasBangunan = venue2['luasBangunan'];
      String luasTanah = venue2['luasTanah'];
      String hargaVenue = formatter.format(int.parse(venue2['hargaVenue']));
      int idCity = venue2['idCity'];
      double latitude = venue2['latitude'];
      double longitude = venue2['longitude'];
      String locationVenue = venue2['locationVenue'];
      listVenueData.add(new VenueModel(
          id,
          linkImageVenue,
          titleVenue,
          addressVenue,
          capacityVisitor,
          capacityParkir,
          luasBangunan,
          luasTanah,
          hargaVenue,
          idCity,
          locationVenue,
          isDay,
          isNight,
          isDayFlag,
          isNightFlag,
          bookingDateVal,
          listBookingDate,
          latitude,
          longitude));
    }
    print(listVenueData.length);
  }

  void _updateBookingDate(List<VenueModel> listVenue) {
    for (var items in listVenue) {
      for (var bookingDate in items.listBookingDate) {
        // items.isDayFlag = 0;
        // items.isNightFlag = 0;
        if (bookingDate['bookingDate'] == parameter.bookingDate) {
          items.isDayFlag = bookingDate['isDay'];
          items.isNightFlag = bookingDate['isNight'];
          break;
        } else {
          items.isDayFlag = 0;
          items.isNightFlag = 0;
        }
        // if (items.bookingDate == parameter.bookingDate) {
        //   items.isDayFlag = items.isDay;
        //   items.isNightFlag = items.isNight;
        // } else {
        //   items.isDayFlag = 0;
        //   items.isNightFlag = 0;
        // }
      }
    }
  }

  Future<String> _getFilterParam(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = (prefs.getString(key) ?? "");
    // print("get from shared Preferenced " + json);
    return json;
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

  @override
  void initState() {
    super.initState();
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(parameter);
    http.getAllVenueWithParam(parameterJson).then((List<dynamic> listVenue) {
      setState(() {
        // _generateCarouselWidget(listVenue);
        _populateResultData(listVenue);
        countSearch = listVenue.length.toString();
      });
    });

    setState(() {
      displayedDate = '28 Agustus 2018';
      if (parameter.bookingDate != null) {
        int bookingDate = parameter.bookingDate;
        int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
        int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
        int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
        displayedDate =
            day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
      }

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
          child: Text(parameter.cityName,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(countSearch + ' available venue',
              style: TextStyle(
                fontSize: 14.0,
              )),
        )
      ],
    );

    _navigateVendorPage(BuildContext context, VenueModel venueModel) {
      parameter.idVenue = venueModel.id;
      // Navigator.pushNamed(context, "/vendorPage");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VendorPageNew(
                  mapController: mapController,
                  overlayController: overlayController,
                  allPages: allPages,
                  venueModel: venueModel,
                  parameter: parameter,
                )),
      );
    }

    Future<Null> _selectDate(
        BuildContext context, List<VenueModel> listVenueData) async {
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
          parameter.bookingDate = selectedDate;
          _updateBookingDate(listVenueData);
          // print(listVenueData);
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
              _selectDate(context, listVenueData);
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
      String fileName = listVenueData.elementAt(index).linkImageVenue;
      String url = HttpServices.getImageByName +
          kParamImageName.replaceAll('<img>', '$fileName');
      return new Container(
          margin: EdgeInsets.only(right: 5.0),
          width: 140.0,
          height: 200.0,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                // image: new AssetImage('assets/images/' +
                //     listVenueData.elementAt(index).linkImageVenue),
                image: new NetworkImage(url),
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
            // Row(
            //   children: <Widget>[
            //     Icon(Icons.terrain),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
            //         child: Text(listVenueData.elementAt(index).luasBangunan,
            //             overflow: TextOverflow.fade,
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 14.0,
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Icon(Icons.terrain),
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
            //         child: Text(listVenueData.elementAt(index).luasTanah,
            //             overflow: TextOverflow.fade,
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 14.0,
            //             )),
            //       ),
            //       flex: 1,
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 4.0, top: 30.0, right: 10.0),
                  child: Text('Rp.' + listVenueData.elementAt(index).hargaVenue,
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
            // color: Colors.grey[300],
            color: listVenueData.elementAt(index).isDayFlag == 1 &&
                    listVenueData.elementAt(index).isNightFlag == 1
                ? Colors.grey[300]
                : Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            child: InkWell(
              onTap: () {
                _navigateVendorPage(context, listVenueData.elementAt(index));
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
