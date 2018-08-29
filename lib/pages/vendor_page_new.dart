import 'dart:convert';

import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/booking_model.dart';
import 'package:bride_story/models/venue_model.dart';
import 'package:bride_story/pages/booking_entry_dialog.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/pages/google_maps_detail_new.dart';
import 'package:bride_story/pages/webview_page.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';

import 'package:intl/intl.dart';

class VendorPageNew extends StatefulWidget {
  final GoogleMapController mapController;
  final GoogleMapOverlayController overlayController;
  final List<PageNew> allPages;
  final VenueModel venueModel;
  final FilterParam parameter;

  VendorPageNew(
      {Key key,
      this.mapController,
      this.overlayController,
      this.allPages,
      this.venueModel,
      this.parameter})
      : super(key: key);

  @override
  _VendorPageNewState createState() => _VendorPageNewState(
      mapController, overlayController, allPages, venueModel, parameter);
}

class _VendorPageNewState extends State<VendorPageNew>
    with SingleTickerProviderStateMixin {
  _VendorPageNewState(this.mapController, this.overlayController, this.allPages,
      this.venueModel, this.parameter);
  GoogleMapController mapController;
  GoogleMapOverlayController overlayController;
  List<PageNew> allPages;
  VenueModel venueModel;
  FilterParam parameter;
  String urlVenueImage;
  String urlSimilarVenueImage;
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;
  String displayedDate = "";
  GoogleMapOverlayController previewMap;
  List<BookingData> weightSaves = new List();
  int _markerCount = 0;
  static final LatLng center = const LatLng(-6.1541491, 106.8893441);
  final formatter = new NumberFormat("#,###");
  // List<Widget> listWidgetSimilarVenue = [];
  Animation<double> animation;
  AnimationController controller;
  List<VenueModel> listSimilarVenueData = new List<VenueModel>();
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
      listSimilarVenueData.add(new VenueModel(
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
  }

  initState() {
    super.initState();
    similarVenueData();
    _add();
    displayedDate = '28 Agustus 2018';
    int year =
        new DateTime.fromMillisecondsSinceEpoch(parameter.bookingDate).year;
    int month =
        new DateTime.fromMillisecondsSinceEpoch(parameter.bookingDate).month;
    int day =
        new DateTime.fromMillisecondsSinceEpoch(parameter.bookingDate).day;
    displayedDate =
        day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
    String fileName = venueModel.linkImageVenue;
    urlVenueImage = HttpServices.getImageByName +
        kParamImageName.replaceAll('<img>', '$fileName');
    previewMap = GoogleMapOverlayController.fromSize(
      width: 450.0,
      height: 200.0,
      options: GoogleMapOptions(
          cameraPosition: CameraPosition(
            bearing: 270.0,
            target: LatLng(venueModel.latitude, venueModel.longitude),
            tilt: 10.0,
            zoom: 16.0,
          ),
          trackCameraPosition: true,
          scrollGesturesEnabled: true),
    );
  }

  void _updateBookingDate(VenueModel venueModel) {
    // for (var items in listVenue) {
    for (var bookingDate in venueModel.listBookingDate) {
      if (bookingDate['bookingDate'] == parameter.bookingDate) {
        venueModel.isDayFlag = bookingDate['isDay'];
        venueModel.isNightFlag = bookingDate['isNight'];
        break;
      } else {
        venueModel.isDayFlag = 0;
        venueModel.isNightFlag = 0;
      }
    }
    // }
  }

  void _add() {
    mapController.addMarker(MarkerOptions(
      position: LatLng(
        // center.latitude + sin(_markerCount * pi / 6.0) / 20.0,
        // center.longitude + cos(_markerCount * pi / 6.0) / 20.0,
        center.latitude,
        center.longitude,
      ),
      infoWindowText: InfoWindowText('Marker #${_markerCount + 1}', '*'),
    ));
    setState(() {
      _markerCount += 1;
    });
  }

  void _showDialogCustom(dynamic response) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CustomAlertDialog(
          title: new Text("Info",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
          content: new Text(response['otherMessage'],
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

  void _updateVenueData(List<dynamic> listVenue) {
    for (var items in listVenue) {
      Map venue = items; //store each map
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
          bookingDateVal = bookingDate['bookingDate'];
        }
      }
      setState(() {
        venueModel.isDay = isDay;
        venueModel.isNight = isNight;
        venueModel.isDayFlag = isDayFlag;
        venueModel.isNightFlag = isNightFlag;
        venueModel.listBookingDate = listBookingDate;
      });
    }
  }

  void similarVenueData() {
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(parameter);
    http.getListSimilarVenue(parameterJson).then((List<dynamic> listVenue) {
      setState(() {
        if (listVenue.length > 0) {
          _populateResultData(listVenue);
        }
      });
    });
  }

  void refreshVenue() {
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(parameter);
    print(parameter.idVenue);
    http.getVenueWithIdVenue(parameterJson).then((List<dynamic> listVenue) {
      setState(() {
        if (listVenue.length > 0) {
          _updateVenueData(listVenue);
          _updateBookingDate(venueModel);
        }
      });
    });
  }

  Future _openAddEntryDialog() async {
    dynamic save =
        await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
            builder: (BuildContext context) {
              return new BookingEntryDialog.add(
                  venueModel.id, parameter.bookingDate);
            },
            fullscreenDialog: false));
    print(save);
    if (save != null) {
      _showDialogCustom(save);
      refreshVenue();
    }
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var buttonBooking = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 9.0, bottom: 9.0),
      child: Material(
          elevation: 4.0,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              _openAddEntryDialog();
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  new Text('Booking',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          )),
    );

    Widget otherVenueImagesNew(BuildContext context, int index) {
      String fileName = listSimilarVenueData.elementAt(index).linkImageVenue;
      urlSimilarVenueImage = HttpServices.getImageByName +
          kParamImageName.replaceAll('<img>', '$fileName');
      return GestureDetector(
        onTap: () {
                _navigateVendorPage(context, listSimilarVenueData.elementAt(index));
              },
        child: new Stack(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(urlSimilarVenueImage),
                    ))),
            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
              child: new Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(15.0),
                        // bottomRight: Radius.circular(15.0)
                        ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        listSimilarVenueData.elementAt(index).titleVenue,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      new Text(
                        listSimilarVenueData.elementAt(index).locationVenue +
                            ', Indonesia',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      new Text(
                        'Venue',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )),
              // ),
              //  ),
            ),
          ],
        ),
      );
    }

    Widget otherVenueImages = new Container(
      // width: screenWidth,
      height: 200.0,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listSimilarVenueData.length,
        itemBuilder: (BuildContext context, int index) {
          return otherVenueImagesNew(context, index);
        },
      ),
    );

    Widget otherVenueRow = new Container(
      padding: EdgeInsets.all(12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text("Similar Venue", style: TextStyle(fontSize: 14.0)),
          new GestureDetector(
            child: new Text(
                "View All (" + listSimilarVenueData.length.toString() + ") >",
                style: TextStyle(fontSize: 14.0)),
            onTap: () {
              // _navigateProjectListPage(context);
            },
          )
        ],
      ),
    );

    Widget addressRow = new Container(
      padding: EdgeInsets.all(12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Icon(Icons.add_location),
          Expanded(
            flex: 1,
            child: new Text(venueModel.addressVenue,
                style: TextStyle(fontSize: 14.0)),
          )
        ],
      ),
    );

    Widget namaVendor = new Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 7.0, top: 7.0, bottom: 7.0),
      child: new Text(venueModel.titleVenue, style: TextStyle(fontSize: 18.0)),
    );

    Widget bgImage = new Container(
      height: screenHeight / 3,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(urlVenueImage),
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget banner2 = new Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.yellow.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'View 4D Here',
          style: TextStyle(
            // fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    Widget bannerMap = new Padding(
      padding: const EdgeInsets.only(top: 70.0, left: 120.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.yellow.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'Show Detail Map',
          style: TextStyle(
            // fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    Widget roundedImage = new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          height: 50.0,
        ),
        GestureDetector(
          child: Center(
            child: banner2,
          ),
          onTap: () {
            _navigateTo4DPage(context);
          },
        ),
      ],
    );

    var header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(venueModel.titleVenue,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(parameter.cityName + ',Indonesia',
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
          int year = new DateTime.fromMillisecondsSinceEpoch(selectedDate).year;
          int month =
              new DateTime.fromMillisecondsSinceEpoch(selectedDate).month;
          int day = new DateTime.fromMillisecondsSinceEpoch(selectedDate).day;
          displayedDate = day.toString() +
              ' ' +
              _convertBulan(month) +
              ' ' +
              year.toString();
          _updateBookingDate(venueModel);
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
                  Padding(padding: EdgeInsets.all(5.0)),
                  Column(
                    children: <Widget>[
                      Icon(Icons.wb_sunny),
                      Text(venueModel.isDayFlag == 1 ? 'Booked' : 'Available',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                          )),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Column(
                    children: <Widget>[
                      Icon(Icons.wb_cloudy),
                      Text(venueModel.isNightFlag == 1 ? 'Booked' : 'Available',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );

    return SafeArea(
      child: new Scaffold(
          appBar: new AppBar(
            title: header,
          ),
          body: new ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  bgImage,
                  roundedImage,
                ],
              ),
              namaVendor,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              GestureDetector(
                child: Stack(
                  children: <Widget>[
                    GoogleMapOverlay(controller: previewMap),
                    bannerMap,
                  ],
                ),
                onTap: () {
                  _navigateMapsDetailPage(context, allPages[0], venueModel);
                },
              ),
              addressRow,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              selectedDateView,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              buttonBooking,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              otherVenueRow,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              otherVenueImages,
            ],
          )),
    );
  }

  void _navigateMapsDetailPage(
      BuildContext context, PageNew page, VenueModel venueModel) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new GoogleMapsDetailNew(
                mapController: page.controller.mapController,
                overlayController: page.controller,
                lat: venueModel.latitude,
                lng: venueModel.longitude,
                title: venueModel.titleVenue,
                subTitle: parameter.cityName + ',Indonesia',
              )),
    );
  }

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

  void _navigateTo4DPage(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new WebviewPage(
                url: "https://roundme.com/tour/291549/view/919147/",
              )),
    );
  }
}
