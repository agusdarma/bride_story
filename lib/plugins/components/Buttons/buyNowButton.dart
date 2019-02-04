import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../theme/style.dart';

class BuynowButton extends StatelessWidget {
  final String text;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Column(
      children: <Widget>[
        new InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/productList");
          },
          child: new Container(
            child: new Text(
              defaultTargetPlatform == TargetPlatform.android ? text : text,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            height: screenSize.height / 20.0,
            width: screenSize.width / 5.2,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
              color: gotobagColor,
              borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
            ),
          ),
        ),
      ],
    );
  }

  BuynowButton({this.text});
}
