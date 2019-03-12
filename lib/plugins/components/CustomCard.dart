import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData trailingIcon;
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(
            width: 0.3,
            color: Colors.grey,
          ))),
      child: new Container(
        margin: const EdgeInsets.only(left: 0.0, right: 10.0),
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Icon(
                icon,
                color: new Color.fromRGBO(153, 153, 153, 1.0),
              ),
              new Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: new Text(
                    text,
                    style: new TextStyle(
                        color: new Color.fromRGBO(119, 119, 119, 1.0),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
          trailing: new Icon(
            trailingIcon,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  CustomCard({this.icon, this.text, this.trailingIcon});
}
