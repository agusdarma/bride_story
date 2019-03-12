import 'package:flutter/material.dart';
import 'package:bride_story/theme/style.dart';

class BagCard extends StatelessWidget {
  final ExactAssetImage picture;

  final String text;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(
              width: 0.3,
              color: Colors.grey,
            ))),
        child: new Container(
          margin: const EdgeInsets.only(
              left: 5.0, top: 8.0, bottom: 0.0, right: 0.0),
          child: new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Image(
                  image: picture,
                  height: 50.0,
                  width: 40.0,
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        text,
                        style: textStyleSmallBag,
                      ),
                      new Text(
                        text1,
                        style: textStyleSmallBag,
                      ),
                      new Text(
                        text2,
//                        style: textStylesubTitleLightNotification,
                      style: textStyleSmallBag,
                      ),
                      new Text(
                        text3,
//                        style: yellow,
                        style: textStyleSmallBag,
                      ),
                      new Text(
                        text4,
//                        style: textStylesubBag,
                        style: textStyleSmallBag,
                      ),
                      new Text(
                        text5,
//                        style: textStylesubBagpriceActual,
                        style: textStyleSmallBag,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BagCard(
      {this.picture,
      this.text,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.text5});
}
