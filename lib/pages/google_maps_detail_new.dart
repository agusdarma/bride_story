import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsDetailNew extends PageNew {
  final GoogleMapController mapController;
  final double lat;
  final double lng;
  final String title;
  final String subTitle;
  final GoogleMapOverlayController overlayController;

  GoogleMapsDetailNew(
      {this.overlayController,
      this.mapController,
      this.lat,
      this.lng,
      this.title,
      this.subTitle})
      : super(mapController, lat, lng, title, overlayController);

  @override
  _GoogleMapsDetailNewState createState() => _GoogleMapsDetailNewState(
      mapController, lat, lng, title, subTitle, overlayController, controller);

  @override
  final GoogleMapOverlayController controller =
      GoogleMapOverlayController.fromSize(
    width: 500.0,
    height: 300.0,
    options: GoogleMapOptions(
      cameraPosition: const CameraPosition(
        bearing: 270.0,
        target: LatLng(-6.1541491, 106.8893441),
        tilt: 10.0,
        zoom: 16.0,
      ),
      trackCameraPosition: true,
    ),
  );
}

class _GoogleMapsDetailNewState extends State<GoogleMapsDetailNew> {
  _GoogleMapsDetailNewState(this.mapController, this.lat, this.lng, this.title,
      this.subTitle, this.overlayController, this.overlayAwal);
  GoogleMapController mapController;
  GoogleMapOverlayController overlayController;
  GoogleMapOverlayController overlayAwal;
  double lat;
  double lng;
  int _markerCount = 0;
  String title;
  String subTitle;

  initState() {
    super.initState();
    _addMarker();
    print('ini overlay awal ' +
        overlayAwal.overlayController.hashCode.toString());

    print('ini overlay controller ' +
        overlayController.overlayController.hashCode.toString());

    mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(lat, lng),
      ),
    );
  }

  dispose() {
    super.dispose();
  }

  void _addMarker() {
    overlayController.mapController.addMarker(MarkerOptions(
      position: LatLng(
        lat,
        lng,
      ),
      infoWindowText: InfoWindowText('Marker #${_markerCount + 1}', '*'),
    ));
    setState(() {
      _markerCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(title,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(subTitle,
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
            GoogleMapOverlay(
              controller: overlayController,
            ),
          ],
        ),
      ),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: <Widget>[
    //     // mapWidget,
    //     GoogleMapOverlay(
    //       controller: overlayController,
    //     )
    //   ],
    // );
  }
}
