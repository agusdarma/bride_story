import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';
import '../models/result_search_model.dart';

class ResultSearchPage extends StatefulWidget {
  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  // List<TextSpan> listSubtitle;
  String text = "Loading";
  List<ResultSearchModel> listResultData = new List<ResultSearchModel>();
  FilterParam filterParamNew;

/*
for demo hardcode
 */
  void _populateResultData() {
    listResultData.add(new ResultSearchModel(
        "assets/images/1.jpg",
        "Jova Musique",
        "32",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/2.jpg",
        "Port Love Creative Studio",
        "16",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/3.jpg",
        "Port Love Creative Studio 2",
        "17",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/3.jpg",
        "Port Love Creative Studio 2",
        "17",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/3.jpg",
        "Port Love Creative Studio 2",
        "17",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/3.jpg",
        "Port Love Creative Studio 2",
        "17",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    listResultData.add(new ResultSearchModel(
        "assets/images/3.jpg",
        "Port Love Creative Studio 2",
        "17",
        filterParamNew.categoryName,
        filterParamNew.cityName,
        "assets/images/1.jpg",
        "assets/images/2.jpg",
        "assets/images/3.jpg",
        "assets/images/4.jpg"));
    print(listResultData.length);
  }

  Future<String> _getFilterParam(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = (prefs.getString(key) ?? "");
    print("get from shared Preferenced " + json);
    return json;

    // _populateResultData();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // listSubtitle = new List<TextSpan>();
      _getFilterParam(keyFilterParam).then((result) {
        setState(() {
          updateSubtitle(result);
        });
      });
      // text = "aisssssssssssssssssssssssssssss";
      // listSubtitle.add(new TextSpan(text: "Loading...."));
    });
  }

  Future updateSubtitle(String json) async {
    print(json);   
    await new Future.delayed(const Duration(seconds: 2)); 
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(json);
    filterParamNew = new FilterParam.fromJson(filterParamMap);
    // listSubtitle.clear();
    // listSubtitle.add(new TextSpan(text: "Showing result for "));
    // listSubtitle.add(new TextSpan(
    //     text: filterParamNew.categoryName,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //     )));
    // listSubtitle.add(new TextSpan(text: " "));
    // listSubtitle.add(new TextSpan(text: "in "));
    // listSubtitle.add(new TextSpan(
    //     text: filterParamNew.cityName,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //     )));
    // listSubtitle.add(new TextSpan(text: " "));
    // listSubtitle.add(new TextSpan(
    //     text: filterParamNew.countryName,
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //     )));
    // listSubtitle.add(new TextSpan(text: " "));
    setState(() {
    text = filterParamNew.categoryName;
    _populateResultData();      
        });
    
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Widget highlightImages = new Container(
      padding: EdgeInsets.all(10.0),
      height: 100.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/2.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/3.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/4.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/2.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/1.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/2.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/3.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/1.jpg"),
                  ))),
          new Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(right: 5.0),
              width: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/images/4.jpg"),
                  ))),
        ],
      ),
    );

    Widget subtitle = new Container(
      width: screenWidth - 1,
      // padding: new EdgeInsets.all(3.0),
      color: new Color(0X33000000),
      child: new Text(text),
      // new RichText(
      //   text: new TextSpan(
      //       children: listSubtitle,
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 14.0,
      //       )),
      // )
    );

    _navigateVendorPage(BuildContext context) {
      Navigator.pushNamed(context, "/vendorPage");
    }

    Widget content(BuildContext context, int index) {
      return new Container(
          padding: EdgeInsets.only(top: 20.0, left: 10.0, bottom: 20.0),
          child: Column(children: <Widget>[
            new Row(
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    _navigateVendorPage(context);
                  },
                  child: new Container(
                      margin: EdgeInsets.only(right: 5.0),
                      width: 60.0,
                      height: 60.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(listResultData
                                .elementAt(index)
                                .linkProfileImage),
                          ))),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new GestureDetector(
                          onTap: () {
                            _navigateVendorPage(context);
                          },
                          child: new Container(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: new Text(
                                listResultData.elementAt(index).titleVendor,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      new GestureDetector(
                          onTap: () {
                            _navigateVendorPage(context);
                          },
                          child: new Container(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: new Text(
                                listResultData.elementAt(index).categoryName,
                                style: TextStyle(
                                  fontSize: 11.0,
                                )),
                          )),
                      new GestureDetector(
                          onTap: () {
                            _navigateVendorPage(context);
                          },
                          child: new Row(
                            children: <Widget>[
                              new Icon(Icons.star),
                              new Icon(Icons.star),
                              new Icon(Icons.star),
                              new Icon(Icons.star),
                              new Text(
                                  listResultData.elementAt(index).countReviews +
                                      " Reviews >",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ))
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
            new GestureDetector(
              onTap: () {
                _navigateVendorPage(context);
              },
              child: highlightImages,
            ),
          ]));
    }

    return SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              title: new TextField(
                decoration: new InputDecoration(
                    hintText: "Search Vendors, Articles Here"),
              ),
            ),
            body: new Column(
              children: <Widget>[
                subtitle,
                new Expanded(
                  child: new Container(
                    child: new ListView.builder(
                      itemCount: listResultData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return content(context, index);
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
