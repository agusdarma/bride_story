import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../models/country_model.dart';
import '../utils/constant.dart';
import 'dart:convert';

class ResultSearchPage extends StatefulWidget {
  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  @override
  Widget build(BuildContext context) {
    Widget subtitle = new Container(
      padding: new EdgeInsets.all(12.0),
      color: new Color(0X33000000),
      child:
          new Text('Showing result for All Categories in Jakarta, Indonesia'),
    );

    Widget listImagesContent = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Container(
            // padding: EdgeInsets.only(right: 5.0),
            child: new Image(
          width: 100.0,
          height: 100.0,
          image: new AssetImage('assets/images/1.jpg'),
        )),
        new Container(
            // padding: EdgeInsets.all(8.0),
            child: new Image(
          width: 100.0,
          height: 100.0,
          image: new AssetImage('assets/images/1.jpg'),
        )),
        new Container(
            // padding: EdgeInsets.all(8.0),
            child: new Image(
          width: 100.0,
          height: 100.0,
          image: new AssetImage('assets/images/1.jpg'),
        )),
        new Container(
            // padding: EdgeInsets.all(8.0),
            child: new Image(
          width: 100.0,
          height: 100.0,
          image: new AssetImage('assets/images/1.jpg'),
        )),
      ],
    );

    Widget content = new Container(
        padding: EdgeInsets.all(16.0),
        child: new Row(
          children: <Widget>[
            new Container(
                margin: EdgeInsets.only(right: 10.0),
                width: 70.0,
                height: 70.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/images/1.jpg'),
                    ))),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text("Jova Musique",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text("Entertainment Music,Jakarta",
                        style: TextStyle(
                          fontSize: 14.0,
                        )),
                  ),
                  new Row(
                    children: <Widget>[
                      new Icon(Icons.star),
                      new Icon(Icons.star),
                      new Icon(Icons.star),
                      new Icon(Icons.star),
                      new Text("32 Reviews >",
                          style: TextStyle(
                            fontSize: 14.0,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));

    Widget rowData = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[content, listImagesContent, new Divider(height: 2.0)],
    );

    return SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              title: new TextField(
                decoration: new InputDecoration(
                    hintText: "Search Vendors, Articles Here"),
              ),
            ),
            body: new ListView(
              children: <Widget>[
                subtitle,
                rowData,
                rowData,
                rowData,
                rowData,
                rowData,
                rowData,
              ],
            )));
  }
}
