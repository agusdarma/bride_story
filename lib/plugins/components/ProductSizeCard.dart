import 'package:flutter/material.dart';

class ProductSizeCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String text1;
  @override
  Widget build(BuildContext context) {
    return new Container(
//      color: Colors.white,
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(
//              width: 0.3,
            color: Colors.white,
          ))),
      child: new Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Icon(
                icon,
                size: 15.0,
                color: new Color.fromRGBO(153, 153, 153, 1.0),
              ),
              new Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: new Text(
                    text,
                    style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
          trailing: new Text(
            text1,
            style: new TextStyle(
                color: const Color.fromRGBO(116, 104, 197, 1.0),
                fontSize: 12.0,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  ProductSizeCard({this.icon, this.text, this.text1});
}
