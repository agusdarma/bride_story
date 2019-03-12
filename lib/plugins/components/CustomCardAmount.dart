import 'package:flutter/material.dart';

class CustomCardAmount extends StatelessWidget {
  final String text;
  final String text1;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Container(
        margin: const EdgeInsets.only(left: 0.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(
              width: 0.3,
              color: Colors.grey,
            ))),
        child: new Container(
          child: new ListTile(
              title: new Row(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: new Text(
                        text,
                        style: new TextStyle(
                            color: const Color.fromRGBO(85, 85, 85, 1.0),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300),
                      )),
                ],
              ),
              trailing: new Text(
                text1,
                style: new TextStyle(
                  fontSize: 14.0,
                  fontWeight: fontWeight,
                  color: color,
                ),
              )),
        ),
      ),
    );
  }

  CustomCardAmount({this.text, this.text1, this.color, this.fontWeight});
}
