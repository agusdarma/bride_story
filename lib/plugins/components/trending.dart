import 'package:flutter/material.dart';

class Trending extends StatelessWidget {
  final ExactAssetImage picture;
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.only(
            left: 10.0, top: 0.0, bottom: 10.0, right: 10.0),
        child: new Image(
          image: picture,
          height: 200.0,
          fit: BoxFit.cover,
        ));
  }

  Trending({this.picture});
}
