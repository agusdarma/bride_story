import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/result_search_model.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultSearchPageNew extends StatefulWidget {
  @override
  _ResultSearchPageNewState createState() => _ResultSearchPageNewState();
}

class _ResultSearchPageNewState extends State<ResultSearchPageNew> {
  String text = "Loading";
  List<ResultSearchModel> listResultData = new List<ResultSearchModel>();
  FilterParam filterParamNew;

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
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getFilterParam(keyFilterParam).then((result) {
        setState(() {
          updateSubtitle(result);
        });
      });
    });
  }

  Future updateSubtitle(String json) async {
    print(json);
    await new Future.delayed(const Duration(seconds: 2));
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(json);
    filterParamNew = new FilterParam.fromJson(filterParamMap);
    setState(() {
      text = "Search result for " +
          filterParamNew.categoryName +
          " in " +
          filterParamNew.cityName +
          " ," +
          filterParamNew.countryName;
      _populateResultData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text('Jakarta',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Text('428 available venue',
              style: TextStyle(
                fontSize: 14.0,
              )),
        )
      ],
    );
    var selectedDateView = Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              // _navigateAndDisplaySelection(context);
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.date_range),
                  Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: new Text('28 Agustus 2018',
                        style: TextStyle(
                          fontSize: 15.0,
                        )),
                  ),
                  Text('Changes',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          )),
    );

    var imageVenue = new Container(
        margin: EdgeInsets.only(right: 5.0),
        width: 140.0,
        height: 200.0,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new AssetImage("assets/images/1.jpg"),
            )));
    var descVenue = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 4.0, bottom: 5.0),
            child: Text('Oasis Amir Hotel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                )),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.store),
              Container(
                padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                child: Text('Jln Jendral Sudirman',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.view_module),
              Container(
                padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                child: Text('Kapasitas ruangan : 1500 tamu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.local_parking),
              Container(
                padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                child: Text('Kapasitas parkir : 1500 mobil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.terrain),
              Container(
                padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                child: Text('Luas bangunan 500 m2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    )),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.terrain),
              Container(
                padding: EdgeInsets.only(left: 4.0, bottom: 2.0),
                child: Text('Luas lahan 800 m2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 4.0, top: 30.0,right: 4.0),
                child: Text('Rp. 30.000.000',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    )),
              ),
            ],
          )
        ],
      ),
    );

    var detailVenueView = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 9.0, right: 9.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  imageVenue,
                  descVenue,
                ],
              ),
            ),
          )),
    );

    Widget content(BuildContext context, int index) {
      return new Container(
        child: detailVenueView,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          title: header,
        ),
        body: Column(
          children: <Widget>[
            selectedDateView,
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
        ),
      ),
    );
  }
}
