import 'package:bride_story/pages/google_maps_detail.dart';
import 'package:bride_story/pages/google_maps_detail_new.dart';
import 'package:bride_story/pages/webview_page.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

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

  final GoogleMapOverlayController previewMap =
      GoogleMapOverlayController.fromSize(
    width: 400.0,
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

  CameraPosition _position;
  GoogleMapOptions _options;
  bool _isMoving;

  int _markerCount = 0;
  Marker _selectedMarker;
  static final LatLng center = const LatLng(-6.1541491, 106.8893441);

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    mapController.addListener(_onMapChanged);
    _extractMapInfo();
    // mapController.onMarkerTapped.add(_onMarkerTapped);
    _add();

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

  void _onMarkerTapped(Marker marker) {
    if (_selectedMarker != null) {
      _updateSelectedMarker(
        const MarkerOptions(icon: BitmapDescriptor.defaultMarker),
      );
    }
    setState(() {
      _selectedMarker = marker;
    });
    _updateSelectedMarker(
      MarkerOptions(
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
      ),
    );
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

  void _updateSelectedMarker(MarkerOptions changes) {
    mapController.updateMarker(_selectedMarker, changes);
  }

  dispose() {
    controller.dispose();
    mapController.removeListener(_onMapChanged);
    super.dispose();
  }

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  void _extractMapInfo() {
    _options = mapController.options;
    print(_options.scrollGesturesEnabled);

    _position = mapController.cameraPosition;
    // print(_position.target.latitude.toStringAsFixed(4));
    // print(_position.target.longitude.toStringAsFixed(4));

    _isMoving = mapController.isCameraMoving;
    // print(_isMoving);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget _compassToggler() {
      return FlatButton(
        child:
            Text('${_options.compassEnabled ? 'disable' : 'enable'} compass'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(compassEnabled: !_options.compassEnabled),
          );
        },
      );
    }

    Widget _zoomBoundsToggler() {
      return FlatButton(
        child: Text(_options.minMaxZoomPreference.minZoom == null
            ? 'bound zoom'
            : 'release zoom'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(
              minMaxZoomPreference:
                  _options.minMaxZoomPreference.minZoom == null
                      ? const MinMaxZoomPreference(12.0, 16.0)
                      : MinMaxZoomPreference.unbounded,
            ),
          );
        },
      );
    }

    Widget _mapTypeCycler() {
      final MapType nextType =
          MapType.values[(_options.mapType.index + 1) % MapType.values.length];
      return FlatButton(
        child: Text('change map type to $nextType'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(mapType: nextType),
          );
        },
      );
    }

    Widget _rotateToggler() {
      return FlatButton(
        child: Text(
            '${_options.rotateGesturesEnabled ? 'disable' : 'enable'} rotate'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(
              rotateGesturesEnabled: !_options.rotateGesturesEnabled,
            ),
          );
        },
      );
    }

    Widget _scrollToggler() {
      return FlatButton(
        child: Text(
            '${_options.scrollGesturesEnabled ? 'disable' : 'enable'} scroll'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(
              scrollGesturesEnabled: !_options.scrollGesturesEnabled,
            ),
          );
        },
      );
    }

    Widget _tiltToggler() {
      return FlatButton(
        child:
            Text('${_options.tiltGesturesEnabled ? 'disable' : 'enable'} tilt'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(
              tiltGesturesEnabled: !_options.tiltGesturesEnabled,
            ),
          );
        },
      );
    }

    Widget _zoomToggler() {
      return FlatButton(
        child:
            Text('${_options.zoomGesturesEnabled ? 'disable' : 'enable'} zoom'),
        onPressed: () {
          mapController.updateMapOptions(
            GoogleMapOptions(
              zoomGesturesEnabled: !_options.zoomGesturesEnabled,
            ),
          );
        },
      );
    }

    Widget socialMedia = new Container(
      padding: EdgeInsets.all(5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text("Social Media", style: TextStyle(fontSize: 14.0)),
          new Expanded(
            child: new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(right: 5.0),
                    child: new Icon(Icons.polymer),
                  ),
                  new Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: new Icon(Icons.card_giftcard)),
                ],
              ),
            ),
          )
        ],
      ),
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

    Widget projectRow = new Container(
      padding: EdgeInsets.all(12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text("Projects", style: TextStyle(fontSize: 14.0)),
          new GestureDetector(
            child: new Text("View All (5) >", style: TextStyle(fontSize: 14.0)),
            onTap: () {
              _navigateProjectListPage(context);
            },
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

          // new GestureDetector(
          //   child: new Text("View All (5) >", style: TextStyle(fontSize: 14.0)),
          //   onTap: () {
          //     _navigateProjectListPage(context);
          //   },
          // )
        ],
      ),
    );

    Widget buttons = new Container(
      padding: EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new GestureDetector(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(Icons.call),
                new Text("Call", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            onTap: () {
              _navigateCallAction(context);
            },
          ),
          new Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          new GestureDetector(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(Icons.image),
                new Text("4D", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            onTap: () {
              _navigateTo4DPage(context);
            },
          ),
          new Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          new GestureDetector(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(Icons.attach_money),
                new Text("Price List", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            onTap: () {
              _navigateToPriceListPage(context);
            },
          ),
          new Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          new GestureDetector(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(Icons.calendar_today),
                new Text("Booking Date", style: TextStyle(fontSize: 14.0)),
              ],
            ),
            onTap: () {
              _navigateToBookingPage(context);
            },
          )
        ],
      ),
    );

    Widget namaVendor = new Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 7.0, top: 7.0),
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
        Center(
          child: banner2,
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
              ratingVendor,
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
              // buttons,
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

  void _navigateToPriceListPage(BuildContext context) {
    Navigator.pushNamed(context, "/priceListPage");
  }

  // _navigateMapsDetailPage(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     new MaterialPageRoute(
  //         builder: (context) => new GoogleMapsDetailNew(
  //               mapController: mapController,
  //               mapWidget: mapWidget,
  //               overlayController: overlayController,
  //               lat: -6.1541491,
  //               lng: 106.8893441,
  //               title: 'agus darma kusuma',
  //             )),
  //   );
  // }

  void _navigateMapsDetailPage(BuildContext context, PageNew page) {
    print('overlaycontroller hashcode ' +
        page.controller.overlayController.hashCode.toString());
    print('mapController hashcode ' +
        page.controller.mapController.hashCode.toString());
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

  void _navigateCallAction(BuildContext context) {
    UrlLauncher.launch("tel:+6285693938630");
  }

  void _navigateProjectListPage(BuildContext context) {
    Navigator.pushNamed(context, "/projectListPage");
  }

  void _navigateToBookingPage(BuildContext context) {
    Navigator.pushNamed(context, "/bookingPage");
  }
}
