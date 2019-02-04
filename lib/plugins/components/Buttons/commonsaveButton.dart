import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: new InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(text1);
        },
        child: new Container(
          child: new Text(
            defaultTargetPlatform == TargetPlatform.android ? text : text,
            style: new TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          height: screenSize.height / 16.0,
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: const Color.fromRGBO(116, 104, 197, 1.0),
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }

  SaveButton({this.text, this.text1});
}
