import 'package:flutter/material.dart';

class ProductListCard extends StatelessWidget {
  final IconData icon;

  final String buildingName;
  final String buildingAddress;
  final String buildingCapacity;
  final String text3;
  final String text4;

  final VoidCallback changstate;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding:
          const EdgeInsets.only(left: 0.0, bottom: 0.0, top: 2.0, right: 0.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 5.0, right: 20.0, bottom: 0.0),
                    child: new Column(
                      children: <Widget>[
                        new Text(buildingName,
                            style: new TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal)),
                      ],
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 22.0, right: 0.0, bottom: 0.0),
                child: new Icon(
                  icon,
                  color: Colors.grey,
                  size: 20.0,
                ),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 0.0, right: 2.0, bottom: 0.0),
                    child: new Column(
                      children: <Widget>[
                        new Icon(
                            Icons.store,
                            color: Colors.blue,
                            size: 20.0,
                          ),
//                        new Icon(
//                          Icons.store,
//                          color: Colors.blue,
//                          size: 20.0,
//                        ),
//                        new Text(buildingAddress,
//                            style: new TextStyle(
//                                color: Colors.grey,
//                                fontSize: 12.0,
//                                fontWeight: FontWeight.w500,
//                                fontStyle: FontStyle.normal)),
                      ],
                    ),
                  ),
                ],
              ),
                        new Text(buildingAddress,
                            style: new TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal)),
//              new Text('hjhj'),
            ],
          ),
//          new Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              new Padding(
//                padding: const EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
//                child: new Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          top: 5.0, left: 0.0, right: 4.0),
//                      child: new Text(buildingAddress,
//                          style: new TextStyle(
//                            color: Colors.black,
//                            fontSize: 14.0,
//                            fontWeight: FontWeight.w400,
//                          )),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          top: 5.0, left: 0.0, right: 4.0),
//                      child: new Text(text2,
//                          style: new TextStyle(
//                            color: Colors.grey,
//                            fontSize: 12.0,
//                            fontWeight: FontWeight.normal,
//                            fontStyle: FontStyle.italic,
//                            decoration: TextDecoration.lineThrough,
//                          )),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          top: 7.0, left: 0.0, right: 0.0),
//                      child: new Text(text3,
//                          style: new TextStyle(
//                            color: const Color.fromRGBO(116, 104, 197, 1.0),
//                            fontSize: 12.0,
//                            fontWeight: FontWeight.normal,
//                          )),
//                    ),
//                  ],
//                ),
//              ),
//              new Padding(
//                padding: const EdgeInsets.only(top: 7.0, left: 5.0, right: 0.0),
//                child: new Text(text4,
//                    style: new TextStyle(
//                        color: Colors.grey,
//                        fontSize: 12.0,
//                        fontWeight: FontWeight.w500,
//                        fontStyle: FontStyle.normal)),
//              ),
//            ],
//          )
        ],
      ),
    );
  }

  ProductListCard({
    this.icon,
    this.buildingName,
    this.buildingAddress,
    this.buildingCapacity,
    this.text3,
    this.text4,
    this.changstate,
  });
}
