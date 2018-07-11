import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';
import '../models/result_search_model.dart';
import 'dart:ui';

class VendorPage extends StatefulWidget {
  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget projectImages = new Expanded(
      child: new Container(
        height: 200.0,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/2.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/3.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/4.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/2.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/1.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/2.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/3.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/1.jpg"),
                    ))),
            new Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(right: 5.0),
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/4.jpg"),
                    ))),
          ],
        ),
      ),
    );

    Widget projectRow = new Container(
      padding: EdgeInsets.all(12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text("Projects", style: TextStyle(fontSize: 14.0)),
          new Text("View All (5) >", style: TextStyle(fontSize: 14.0)),
        ],
      ),
    );

    Widget buttons = new Container(
      padding: EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Icon(Icons.call),
              new Text("Call", style: TextStyle(fontSize: 14.0)),
            ],
          ),
          new Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          new Column(
            children: <Widget>[
              new Icon(Icons.image),
              new Text("4D", style: TextStyle(fontSize: 14.0)),
            ],
          ),
          new Container(
            height: 30.0,
            width: 1.0,
            color: Colors.black,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          new Column(
            children: <Widget>[
              new Icon(Icons.attach_money),
              new Text("Price List", style: TextStyle(fontSize: 14.0)),
            ],
          )
        ],
      ),
    );

    Widget txtOnline = new Container(
      padding: EdgeInsets.all(8.0),
      child: new Text("Active 11 days ago.", style: TextStyle(fontSize: 14.0)),
    );

    Widget bgImage = new Container(
      height: screenHeight / 3,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
          filter: new ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          )),
    );

    Widget roundedImage = new Column(
      children: <Widget>[
        new Container(
          height: 50.0,
        ),
        Center(
          child: new Container(
              margin: EdgeInsets.only(right: 5.0),
              width: 80.0,
              height: 80.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/2.jpg"),
                  ))),
        ),
        new Container(
            padding: EdgeInsets.only(top: 10.0),
            child: new Center(
              child: Text(
                "Port Love Creative Studio 2",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            )),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(right: 2.0),
                child: new Center(
                  child: Text(
                    "Hair & Makeup",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                )),
            new Container(
                padding: EdgeInsets.only(right: 2.0),
                child: new Center(
                  child: Text(
                    "Jakarta,",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                )),
            new Container(
                padding: EdgeInsets.only(right: 2.0),
                child: new Center(
                  child: Text(
                    "Indonesia",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                )),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.star,
              color: Colors.white,
            ),
            new Icon(
              Icons.star,
              color: Colors.white,
            ),
            new Icon(
              Icons.star,
              color: Colors.white,
            ),
            new Icon(
              Icons.star,
              color: Colors.white,
            ),
            new Container(
                padding: EdgeInsets.only(right: 2.0),
                child: new Center(
                  child: Text(
                    "32",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                )),
            new Container(
                padding: EdgeInsets.only(right: 2.0),
                child: new Center(
                  child: Text(
                    "reviews",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                )),
          ],
        ),
      ],
    );

    return SafeArea(
      child: new Scaffold(
          appBar: AppBar(
            title: new TextField(
              decoration: new InputDecoration(
                  hintText: "Search Vendors, Articles Here"),
            ),
          ),
          body: new Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  bgImage,
                  roundedImage,
                ],
              ),
              txtOnline,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              buttons,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              projectRow,
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              projectImages,
              new Text("data"),
              new Text("data2"),
            ],
          )),
    );
  }
}
