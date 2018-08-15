import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsDetail extends StatefulWidget {
  final Widget mapWidget;
  final GoogleMapController mapController;
  final double lat;
  final double lng;

  GoogleMapsDetail(
      {Key key,
      @required this.mapWidget,
      @required this.mapController,
      @required this.lat,
      @required this.lng})
      : super(key: key);

  @override
  _GoogleMapsDetailState createState() =>
      _GoogleMapsDetailState(mapController, mapWidget, lat, lng);
}

class _GoogleMapsDetailState extends State<GoogleMapsDetail> {
  _GoogleMapsDetailState(
      this.mapController, this.mapWidget, this.lat, this.lng);
  Widget mapWidget;
  GoogleMapController mapController;
  double lat;
  double lng;
  int _markerCount = 0;
  Marker _selectedMarker;
  CameraPosition _position;
  GoogleMapOptions _options;
  bool _isMoving;

  initState() {
    super.initState();
    mapController.addListener(_onMapChanged);
    _extractMapInfo();
    // mapController.onMarkerTapped.add(_onMarkerTapped);
    _add();
    mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(lat, lng),
      ),
    );
  }

  dispose() {
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
    _position = mapController.cameraPosition;
    _isMoving = mapController.isCameraMoving;
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
        lat,
        lng,
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

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            mapWidget,
          ],
        ),
      ),
    );
  }
}
