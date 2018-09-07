import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/booking_param.dart';
import 'package:bride_story/models/result_mybooking.dart';
import 'package:bride_story/pages/login_page_new.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingPage extends StatefulWidget {
  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  List<ResultMyBookingModel> listMyBookingData =
      new List<ResultMyBookingModel>();

  BookingParam parameter;

  void _populateResultData(List<dynamic> listBooking) {
    for (var items in listBooking) {
      Map booking = items;
      String namaPernikahan = booking['namaPernikahan'];
      String namaPenanggungJawab1 = booking['namaPenanggungJawab1'];
      String handPhone1 = booking['handPhone1'];
      String namaPenanggungJawab2 = booking['namaPenanggungJawab2'];
      String handPhone2 = booking['handPhone2'];
      String userEmailBooking = booking['userEmailBooking'];
      String titleVenue = booking['titleVenue'];
      listMyBookingData.add(new ResultMyBookingModel(
          namaPernikahan,
          namaPenanggungJawab1,
          handPhone1,
          namaPenanggungJawab2,
          handPhone2,
          userEmailBooking,
          titleVenue));
    }
  }

  Future<String> getLoginDataSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = "";
    json = (prefs.getString(key) ?? "");
    print("getLoginDataSharedPreferences " + json);
    return json;
  }

  _navigateLoginPage(BuildContext context) {
    Navigator.push(
      context,
      // new MaterialPageRoute(builder: (context) => new LoginScreen()),
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();

    getLoginDataSharedPreferences(keyLoginParam).then((String json) {
      const JsonDecoder decoder = const JsonDecoder();
      Map loginParamVO = decoder.convert(json);
      String sessionData = loginParamVO['sessionData'];
      String email = loginParamVO['email'];
      int sessionDate = loginParamVO['sessionDate'];
      int timeOutLogin = loginParamVO['timeOutLoginSetting'];
      // String phoneNo = loginParamVO['phoneNo'];
      // String password = loginParamVO['password'];
      if (sessionData.isEmpty) {
        _navigateLoginPage(context);
      } else {
        DateTime currentTime = new DateTime.now();
        DateTime sessionTime = DateTime.fromMillisecondsSinceEpoch(sessionDate);
        print(currentTime);
        print(sessionTime);
        print(currentTime.difference(sessionTime).inSeconds);
        if (currentTime.difference(sessionTime).inSeconds > timeOutLogin) {
          _navigateLoginPage(context);
        } else {
          parameter.email = email;
          HttpServices http = new HttpServices();
          const JsonEncoder encoder = const JsonEncoder();
          String parameterJson = encoder.convert(parameter);
          http
              .getListMyBooking(parameterJson)
              .then((List<dynamic> listBooking) {
            setState(() {
              _populateResultData(listBooking);
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget card(BuildContext context, int index) {
      return new Card(
        child: new Column(
          children: <Widget>[
            new Divider(
              color: Colors.blue,
              indent: 1.0,
            ),
            new ListTile(
              leading: new Icon(
                Icons.add_location,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                "Balai Samudra",
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
              subtitle: new Text("7 Agustus 2019"),
            ),
            // new Divider(
            //   color: Colors.blue,
            //   indent: 16.0,
            // ),
            new ListTile(
              leading: new Icon(
                Icons.people,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                "Hendra & Santi",
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            new ListTile(
              leading: new Icon(
                Icons.phone,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                "085694949393",
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );
    }

    Widget sizedBox(BuildContext context, int index) {
      return new Container(
          margin: new EdgeInsets.only(left: 6.0, right: 6.0),
          child: new SizedBox(
            // height: 220.0,
            child: card(context, index),
          ));
    }

    Widget center(BuildContext context, int index) {
      return new Padding(
        padding: EdgeInsets.all(1.0),
        child: sizedBox(context, index),
      );
    }

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("My Booking")),
        //  body: center,
        body: Column(
          children: <Widget>[
            // selectedDateView,
            new Expanded(
              // flex: 1,
              child: new Container(
                child: new ListView.builder(
                  itemCount: listMyBookingData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return center(context, index);
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
