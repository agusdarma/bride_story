import 'package:bride_story/models/result_mybooking.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';

class BookingConfirmation extends StatefulWidget {
  final ResultMyBookingModel bookingData;

  const BookingConfirmation({Key key, this.bookingData}) : super(key: key);
  @override
  _BookingConfirmationState createState() =>
      _BookingConfirmationState(this.bookingData);
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  _BookingConfirmationState(this.bookingData);

  ResultMyBookingModel bookingData;
  @override
  Widget build(BuildContext context) {
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

    Widget tglBooking(int bookingDate) {
      int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
      int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
      int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
      String displayedDate =
          day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
      return Text(displayedDate);
    }

    Widget card(BuildContext context) {
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
                  bookingData.titleVenue,
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: tglBooking(bookingData.dateTime),
              ),
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
                bookingData.namaPernikahan,
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
                bookingData.handPhone1,
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            new ListTile(
              leading: new Icon(
                Icons.attach_money,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                "Rp. 1000.000",
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );
    }

    Widget sizedBox(BuildContext context) {
      return new Container(
          margin: new EdgeInsets.only(left: 6.0, right: 6.0),
          child: new SizedBox(
            // height: 220.0,
            child: card(context),
          ));
    }

    Widget center(BuildContext context) {
      return new Padding(
        padding: EdgeInsets.all(1.0),
        child: sizedBox(context),
      );
    }

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("Confirmation Booking")),
        body: Column(
          children: <Widget>[
            new Expanded(
              child: new Container(child: center(context)),
            ),
          ],
        ),
      ),
    );
  }
}
