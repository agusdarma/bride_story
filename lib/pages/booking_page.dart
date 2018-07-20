import 'package:bride_story/plugins/calendar/lib/flutter_calendar.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  void handleNewDate(date) {
    print(date);
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("Booking Page")),
        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Text('A Custom Weekly Calendar:'),
              new Calendar(
                onSelectedRangeChange: (range) => print(range),
                isExpandable: true,
                dayBuilder: (BuildContext context, DateTime day) {
                  String a = day.day.toString();
                  if (a == "1") {
                    return new InkWell(
                      onTap: () => print(day),
                      child: new Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.amber)),
                        child: new Text(
                          a,
                        ),
                      ),
                    );
                  } else {
                    return new InkWell(
                      onTap: () => print(day),
                      child: new Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.black38)),
                        child: new Text(
                          a,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
