import 'package:flutter/material.dart';

class ProductListCard extends StatelessWidget {
  final IconData icon;

  final String name;
  final String capacityVisitor;
  final String capacityParkir;
  final String hargaVenue;
  final String text1;
  final String text2;
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
                        top: 3.0, left: 3.0),
                    child: new Column(
                      children: <Widget>[
                        new Text(name,
                            style: new TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal)),
                      ],
                    ),
                  ),

                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 3.0),
                        child: new Text(capacityParkir,
                            style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 3.0),
                        child: new Text(capacityVisitor,
                            style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ],
                  ),

                  new Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 3.0),
                    child: new Text(hargaVenue,
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ProductListCard({
    this.icon,
    this.name,
    this.capacityVisitor,
    this.capacityParkir,
    this.hargaVenue,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.changstate,
  });
}
