import '../../theme/style.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final AssetImage picture;
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Padding(
        padding: const EdgeInsets.only(
            left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
        child: new CircleAvatar(
          //child: new Image(image: women),
          backgroundImage: picture,

          backgroundColor: Colors.grey,
          radius: 40.0,
        ),
      ),
      new Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 0.0, bottom: 10.0, right: 10.0),
          child: new Text(
            text,
            style: textStylesub,
          )),
    ]);
  }

  CircleImage({this.picture, this.text});
}
