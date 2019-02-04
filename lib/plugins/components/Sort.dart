import 'package:flutter/material.dart';

class SortData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Container(
      color: Colors.white,
      height: 300.0,
      child: new Container(
        padding: const EdgeInsets.only(
            left: 0.0, right: 0.0, bottom: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            new Container(
              height: screenSize.height / 20.0,
              width: screenSize.width / 1.0,
              margin: const EdgeInsets.only(
                  left: 0.0, right: 0.0, bottom: 0.0, top: 3.0),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border(
                      bottom: new BorderSide(
                    width: 0.3,
                    color: Colors.grey,
                  ))),
              child: new Column(
                children: <Widget>[
                  new Text(
                    'SORT BY',
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(170, 170, 170, 1.0),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
              child: new Text(
                "Popularity",
                style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(116, 104, 197, 1.0),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
              child: new Text(
                "New",
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(119, 119, 119, 1.0),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
              child: new Text(
                "Discount",
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(119, 119, 119, 1.0),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
              child: new Text(
                "Price: High-Low",
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(119, 119, 119, 1.0),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 12.0, bottom: 12.0, right: 5.0),
              child: new Text(
                "Price: Low-High",
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(119, 119, 119, 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
