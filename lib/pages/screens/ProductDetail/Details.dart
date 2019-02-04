import 'package:bride_story/theme/style.dart';
import 'package:flutter/material.dart';


class Detail extends StatelessWidget {
  final String text;

  @override
  Widget build(BuildContext context) {
    return 
    new Column(
      children: <Widget>[
        new Text(
          text,
          style: textDescription,
        ),
      ],
    );
  }

  Detail({this.text});
}
