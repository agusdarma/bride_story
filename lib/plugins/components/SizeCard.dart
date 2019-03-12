import 'package:flutter/material.dart';

class SizeCard extends StatelessWidget {
  final String text;
  final VoidCallback changstate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: changstate,
        child: new Container(
          width: 60.0,
          height: 35.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            border: new Border.all(
              color: color,
              width: 1.0,
            ),
          ),
          child: new Container(
            child: new Text(text,
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                )),
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
            width: 180.0,
            height: 180.0,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
            ),
          ),
        ));
  }

  SizeCard({this.text, this.changstate, this.color});
}
