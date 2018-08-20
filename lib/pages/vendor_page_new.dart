import 'package:bride_story/pages/google_maps_detail_new.dart';
import 'package:bride_story/pages/webview_page.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';

class VendorPageNew extends StatefulWidget {
  final GoogleMapController mapController;
  final GoogleMapOverlayController overlayController;
  final List<PageNew> allPages;

  VendorPageNew(
      {Key key, this.mapController, this.overlayController, this.allPages})
      : super(key: key);

  @override
  _VendorPageNewState createState() =>
      _VendorPageNewState(mapController, overlayController, allPages);
}

class _VendorPageNewState extends State<VendorPageNew>
    with SingleTickerProviderStateMixin {
  _VendorPageNewState(
      this.mapController, this.overlayController, this.allPages);
  GoogleMapController mapController;
  GoogleMapOverlayController overlayController;
  List<PageNew> allPages;
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;
  String displayedDate = "";

  final GoogleMapOverlayController previewMap =
      GoogleMapOverlayController.fromSize(
    width: 450.0,
    height: 200.0,
    options: GoogleMapOptions(
        cameraPosition: const CameraPosition(
          bearing: 270.0,
          target: LatLng(-6.1541491, 106.8893441),
          tilt: 10.0,
          zoom: 16.0,
        ),
        trackCameraPosition: true,
        scrollGesturesEnabled: true),
  );

  int _markerCount = 0;
  static final LatLng center = const LatLng(-6.1541491, 106.8893441);

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    _add();
    displayedDate = '28 Agustus 2018';
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
      padding: EdgeInsets.only(left: 18.0, right: 18.0,top: 9.0, bottom: 9.0),
      child: Material(
          elevation: 4.0,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              // _navigateSearchButton(context);
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

    Widget banner = new Padding(
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
                'Hotel Hilton',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              new Text(
                'Jakarta, Indonesia',
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
    );

    Widget otherVenueImages = new Container(
      width: screenWidth,
      height: 200.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Stack(
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
                        image: new AssetImage("assets/images/2.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/3.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/4.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/2.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/1.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/2.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/3.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/1.jpg"),
                      ))),
              banner,
            ],
          ),
          new Stack(
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
                        image: new AssetImage("assets/images/4.jpg"),
                      ))),
              banner,
            ],
          )
        ],
      ),
    );

    Widget otherVenueRow = new Container(
      padding: EdgeInsets.all(12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text("Similar Venue", style: TextStyle(fontSize: 14.0)),
          new GestureDetector(
            child: new Text("View All (5) >", style: TextStyle(fontSize: 14.0)),
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
            child: new Text(
                "Jalan Boulevard Barat No. 1, Kelapa Gading Barat, RT.2/RW.9, Kelapa Gading Barat, RT.2/RW.9, Klp. Gading Bar., Klp. Gading, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14240",
                style: TextStyle(fontSize: 14.0)),
          )
        ],
      ),
    );

    Widget namaVendor = new Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 7.0, top: 7.0, bottom: 7.0),
      child: new Text("Balai Sudirman", style: TextStyle(fontSize: 18.0)),
    );

    Widget ratingVendor = new Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8.0, bottom: 5.0),
      child: new Text("Rating 8.5 from 1000 customer",
          style: TextStyle(fontSize: 14.0)),
    );

    Widget bgImage = new Container(
      height: screenHeight / 3,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/1.jpg'),
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
          child: Text('Balai Sudirman',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text('Jakarta,Indonesia',
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
                  Padding(padding: EdgeInsets.all(5.0)),
                  Column(
                    children: <Widget>[
                      Icon(Icons.wb_sunny),
                      Text('Booked',
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
                      Text('Booked',
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
              // ratingVendor,
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
                  _navigateMapsDetailPage(context, allPages[0]);
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
              // socialMedia,
            ],
          )),
    );
  }

  void _navigateMapsDetailPage(BuildContext context, PageNew page) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new GoogleMapsDetailNew(
                mapController: page.controller.mapController,
                overlayController: page.controller,
                lat: -6.1541491,
                lng: 106.8893441,
                title: 'Balai Sudirman',
                subTitle: 'Jakarta,Indonesia',
              )),
    );
  }

  void _navigateTo4DPage(BuildContext context) {
    // Navigator.pushNamed(context, "/webViewPage");
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new WebviewPage(
                url: "https://roundme.com/tour/291549/view/919147/",
              )),
    );
  }
}
