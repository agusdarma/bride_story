import 'package:flutter/material.dart';

class ProductDetailCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData trailingIcon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(
            color: Colors.black26,
          ))),
      child: new Container(
        margin: const EdgeInsets.only(left: 0.0),
        child: new ListTile(
          onTap: onPress,
          title: new Row(
            children: <Widget>[
              new Icon(
                icon,
                size: 15.0,
                color: new Color.fromRGBO(153, 153, 153, 1.0),
              ),
              new Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: new Text(
                    text,
                    style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ProductDetailCard({this.icon, this.text, this.trailingIcon, this.onPress});
}
