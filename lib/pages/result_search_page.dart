import 'dart:async';

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
  SharedPreferences sharedPreferences;
  List<TextSpan> listSubtitle;
  Future<List<TextSpan>> _getFilterParam() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String pref = sharedPreferences.getString(keyFilterParam);
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(pref);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);
      listSubtitle = new List<TextSpan>();
      listSubtitle.add(new TextSpan(text: "Showing result for "));
      listSubtitle.add(new TextSpan(text: filterParamNew.categoryName));
      listSubtitle.add(new TextSpan(text: " "));
      listSubtitle.add(new TextSpan(text: "in "));
      listSubtitle.add(new TextSpan(text: filterParamNew.cityName));
      listSubtitle.add(new TextSpan(text: " "));
      listSubtitle.add(new TextSpan(text: filterParamNew.countryName));
      listSubtitle.add(new TextSpan(text: " "));
      // print(listSubtitle);
      return listSubtitle;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _getFilterParam();
    // });
    _getFilterParam().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        listSubtitle = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getFilterParam();
    print(listSubtitle);
    Widget subtitle = new Container(
        padding: new EdgeInsets.all(12.0),
        color: new Color(0X33000000),
        child: new RichText(
          text: new TextSpan(
              children: listSubtitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              )),
        ));

    Widget listImagesContent = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: new Image(
              fit: BoxFit.fitHeight,
              width: 90.0,
              height: 90.0,
              image: new AssetImage('assets/images/1.jpg'),
            )),
        new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: new Image(
              fit: BoxFit.fitHeight,
              width: 90.0,
              height: 90.0,
              image: new AssetImage('assets/images/1.jpg'),
            )),
        new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: new Image(
              fit: BoxFit.fitHeight,
              width: 90.0,
              height: 90.0,
              image: new AssetImage('assets/images/1.jpg'),
            )),
        new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: new Image(
              fit: BoxFit.fitHeight,
              width: 90.0,
              height: 90.0,
              image: new AssetImage('assets/images/1.jpg'),
            )),
      ],
    );

    Widget content = new Container(
        padding: EdgeInsets.all(5.0),
        child: new Row(
          children: <Widget>[
            new Container(
                margin: EdgeInsets.only(right: 5.0),
                width: 60.0,
                height: 60.0,
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
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: new Text("Jova Musique",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: new Text("Entertainment Music,Jakarta",
                        style: TextStyle(
                          fontSize: 11.0,
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
                            fontSize: 11.0,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));

    Widget rowData = new Column(
      children: <Widget>[content, listImagesContent, new Divider(height: 10.0)],
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
