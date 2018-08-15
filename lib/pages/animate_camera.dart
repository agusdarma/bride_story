// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bride_story/plugins/library_map/page.dart';

class AnimateCameraPage extends Page {
  AnimateCameraPage()
      : super(const Icon(Icons.map), 'Camera control, animated');

  @override
  final GoogleMapOverlayController controller =
      GoogleMapOverlayController.fromSize(width: 400.0, height: 300.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(child: GoogleMapOverlay(controller: controller)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 270.0,
                          target: LatLng(-6.1541491,106.8893441),
                          tilt: 10.0,
                          zoom: 16.0,
                        ),
                      ),
                    );
                  },
                  child: const Text('newCameraPosition'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.newLatLng(
                        const LatLng(-6.1541491,106.8893441),
                      ),
                    );
                  },
                  child: const Text('newLatLng'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: const LatLng(-38.483935, 113.248673),
                          northeast: const LatLng(-8.982446, 153.823821),
                        ),
                        10.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngBounds'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        const LatLng(-6.1541491,106.8893441),
                        16.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngZoom'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.scrollBy(150.0, -225.0),
                    );
                  },
                  child: const Text('scrollBy'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.zoomBy(
                        -0.5,
                        const Offset(30.0, 20.0),
                      ),
                    );
                  },
                  child: const Text('zoomBy with focus'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.zoomBy(-0.5),
                    );
                  },
                  child: const Text('zoomBy'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Text('zoomIn'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Text('zoomOut'),
                ),
                FlatButton(
                  onPressed: () {
                    controller.mapController.animateCamera(
                      CameraUpdate.zoomTo(16.0),
                    );
                  },
                  child: const Text('zoomTo'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
