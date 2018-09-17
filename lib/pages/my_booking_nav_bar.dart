import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/booking_param.dart';
import 'package:bride_story/models/result_mybooking.dart';
import 'package:bride_story/pages/booking_confirmation.dart';
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

  BookingParam parameter = new BookingParam('');

  void _populateResultData(List<dynamic> listBooking, String emailUserLogin) {
    for (var items in listBooking) {
      Map booking = items;
      Map bookingDateVO = booking['bookingDateVO'];
      Map venueVO = booking['venueVO'];
      Map venue = venueVO['venue'];
      String namaPernikahan = bookingDateVO['namaPernikahan'];
      String namaPenanggungJawab1 = bookingDateVO['namaPenanggungJawab1'];
      String handPhone1 = bookingDateVO['handPhone1'];
      String namaPenanggungJawab2 = bookingDateVO['namaPenanggungJawab2'];
      String handPhone2 = bookingDateVO['handPhone2'];
      String userEmailBooking = bookingDateVO['userEmailBooking'];
      String titleVenue = venue['titleVenue'];
      int dateTimeMilisecond = bookingDateVO['dateTimeMilisecond'];
      int bookingId = bookingDateVO['id'];
      listMyBookingData.add(new ResultMyBookingModel(
          namaPernikahan,
          namaPenanggungJawab1,
          handPhone1,
          namaPenanggungJawab2,
          handPhone2,
          userEmailBooking,
          titleVenue,
          dateTimeMilisecond,
          bookingId,
          emailUserLogin));
    }
  }

  Future<String> getLoginDataSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = "";
    json = (prefs.getString(key) ?? "");
    print("getLoginDataSharedPreferences " + json);
    return json;
  }

  _navigateLoginPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      // new MaterialPageRoute(builder: (context) => new LoginScreen()),
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
    if (result != null) {
      setState(() {
        print(result);
        // Map temp = result;
        parameter.email = result['email'];
        HttpServices http = new HttpServices();
        const JsonEncoder encoder = const JsonEncoder();
        String parameterJson = encoder.convert(parameter);
        http.getListMyBooking(parameterJson).then((List<dynamic> listBooking) {
          setState(() {
            _populateResultData(listBooking, parameter.email);
          });
        });
      });
    }
  }

  // _navigateAndDisplaySelection(BuildContext context) async {
  //     final result = await Navigator.pushNamed(context, '/searchCity');
  //     if (result != null) {
  //       setState(() {
  //         const JsonDecoder decoder = const JsonDecoder();
  //         Map filterParamMap = decoder.convert(result);
  //         var filterParamNew = new FilterParam.fromJson(filterParamMap);
  //         displayedString = filterParamNew.cityName;
  //         parameter.cityId = filterParamNew.cityId;
  //         parameter.cityName = filterParamNew.cityName;
  //       });
  //     }
  //   }

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
              _populateResultData(listBooking, email);
            });
          });
        }
      }
    });
  }

  String _convertBulan(int month) {
    String bulan = "";
    if (1 == month) {
      bulan = januari;
    } else if (2 == month) {
      bulan = februari;
    } else if (3 == month) {
      bulan = maret;
    } else if (4 == month) {
      bulan = april;
    } else if (5 == month) {
      bulan = mei;
    } else if (6 == month) {
      bulan = juni;
    } else if (7 == month) {
      bulan = juli;
    } else if (8 == month) {
      bulan = agustus;
    } else if (9 == month) {
      bulan = september;
    } else if (10 == month) {
      bulan = oktober;
    } else if (11 == month) {
      bulan = november;
    } else if (12 == month) {
      bulan = desember;
    }
    return bulan;
  }

  // String tglBooking(int bookingDate) {
  //   int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
  //   int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
  //   int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
  //   String displayedDate =
  //       day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
  //   return displayedDate;
  // }

  Widget tglBooking(int bookingDate) {
    int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
    int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
    int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
    String displayedDate =
        day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
    return Text(displayedDate);
  }

  @override
  Widget build(BuildContext context) {
    _navigateConfirmationPage(
        BuildContext context, ResultMyBookingModel bookingData) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new BookingConfirmation(
                  bookingData: bookingData,
                )),
      );
    }

    Widget card(BuildContext context, int index) {
      return new Card(
        child: new Column(
          children: <Widget>[
            new Divider(
              color: Colors.blue,
              indent: 1.0,
            ),
            GestureDetector(
              child: new ListTile(
                leading: new Icon(
                  Icons.add_location,
                  color: Colors.blue,
                  size: 26.0,
                ),
                title: new Text(
                  listMyBookingData.elementAt(index).titleVenue,
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle:
                    tglBooking(listMyBookingData.elementAt(index).dateTime),
              ),
              onTap: () {
                _navigateConfirmationPage(
                    context, listMyBookingData.elementAt(index));
              },
            ),

            // new Divider(
            //   color: Colors.blue,
            //   indent: 16.0,
            // ),
            GestureDetector(
              child: new ListTile(
                leading: new Icon(
                  Icons.people,
                  color: Colors.blue,
                  size: 26.0,
                ),
                title: new Text(
                  listMyBookingData.elementAt(index).namaPernikahan,
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              onTap: () {
                _navigateConfirmationPage(
                    context, listMyBookingData.elementAt(index));
              },
            ),
            GestureDetector(
              child: new ListTile(
                leading: new Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 26.0,
                ),
                title: new Text(
                  listMyBookingData.elementAt(index).handPhone1,
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              onTap: () {
                _navigateConfirmationPage(
                    context, listMyBookingData.elementAt(index));
              },
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
