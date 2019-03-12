import 'package:flutter/material.dart';
import 'package:bride_story/theme/style.dart';

class BagWishlist extends StatelessWidget {
  final String text;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(
            width: 0.5,
            color: Colors.white,
          ))),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, bottom: 10.0, right: 0.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                  text,
                  style: textStylesubTitleLightBAg,
                ),
                new Text(
                  text1,
                  style: textStylesubTitleLightBAg,
                ),
                new Text(
                  text2,
                  style: textStylesubTitleLightBAg,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BagWishlist({
    this.text,
    this.text1,
    this.text2,
  });
}
