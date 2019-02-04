import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final TextStyle buttonTextStyle;
  final TextAlign textAlign;
  final Color textFieldColor;
  TextButton({
    this.buttonName,
    this.onPressed,
    this.buttonTextStyle,
    this.textAlign,
    this.textFieldColor,
  });
  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      child: new Text(
        buttonName,
        textAlign: textAlign,
        style: buttonTextStyle,
      ),
      onPressed: onPressed,
      color: textFieldColor,
    ));
  }
}
