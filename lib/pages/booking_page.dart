import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrolling_calendar/scrolling_calendar.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  static final Random random = new Random();

  static Iterable<Color> randomColors() => <Color>[]
    // ..addAll(random.nextBool() ? <Color>[] : <Color>[Colors.red])
    // ..addAll(random.nextBool() ? <Color>[] : <Color>[Colors.blue])
    // ..addAll(random.nextBool() ? <Color>[] : <Color>[Colors.green]);
    // ..addAll(<Color>[Colors.green]);
    ..add(Colors.cyan)
    ..add(Colors.deepPurple);
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          appBar: AppBar(
            title: new Text("Booking Page"),
          ),
          body: new ScrollingCalendar(
              firstDayOfWeek: DateTime.monday,
              onDateTapped: (DateTime date) => showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                        content: new Text("You tapped $date"),
                      )),
              selectedDate: new DateTime(2018, 2, 20),
              colorMarkers: (_) => randomColors(),
        )
      ),
    );
  }
}
