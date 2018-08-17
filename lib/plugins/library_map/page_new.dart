import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PageNew extends StatefulWidget {
  const PageNew(this.mapController, this.lat, this.lng, this.title, this.overlayController);

  // final Widget leading;
  final String title;
  final GoogleMapController mapController;
  final GoogleMapOverlayController overlayController;
  final double lat;
  final double lng;

  GoogleMapOverlayController get controller;
}
