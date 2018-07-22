import 'package:bride_story/plugins/calendar/lib/flutter_calendar.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<DateTime> listBooked = new List<DateTime>();
  DateTime _tgl;
  double _opacity;

  void _populateBookedData() {
    // listBooked.add(new DateTime.now());
    listBooked.add(new DateTime(2018, DateTime.july, 22));
    listBooked.add(new DateTime(2018, DateTime.july, 21));
    listBooked.add(new DateTime(2018, DateTime.july, 28));
    listBooked.add(new DateTime(2018, DateTime.july, 29));
    // listBooked.add(new DateTime(2018, 29, 6));
    // listBooked.add(new DateTime(2018, 28, 6));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _populateBookedData();
      _tgl = new DateTime.now();
      _opacity = 0.0;
    });
  }

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
              // new Text('A Custom Weekly Calendar:'),
              new Calendar(
                // onSelectedRangeChange: (range) => print(range),
                isExpandable: false,
                dayBuilder: (BuildContext context, DateTime tgl) {
                  // String a = day.day.toString();
                  for (var i = 0; i < listBooked.length; i++) {
                    String year = listBooked[i].year.toString();
                    String month = listBooked[i].month.toString();
                    String day = listBooked[i].day.toString();
                    String dateOnly = year + month + day;
                    // print('ini day booked ' + dateOnly);
                    String yeara = tgl.year.toString();
                    String montha = tgl.month.toString();
                    String daya = tgl.day.toString();
                    String tglOnly = yeara + montha + daya;
                    // print('ini day ' + tglOnly);
                    if (tglOnly == dateOnly) {
                      return new InkWell(
                        onTap: () => _openDetailTgl(tgl),
                        child: new Container(
                          decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.amber),
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: new Text(
                            tgl.day.toString(),
                          ),
                        ),
                      );
                    }
                  }
                  return new InkWell(
                    onTap: () => _openDetailTgl(tgl),
                    child: new Container(
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38)),
                      child: new Text(
                        tgl.day.toString(),
                      ),
                    ),
                  );
                },
              ),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10.0),
                    child: new Text(_tgl.day.toString(),
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10.0),
                    child: new Text(
                        _convertBulan(_tgl.month) + " " + _tgl.year.toString(),
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0),
                    child: new Text("Siang",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0),
                    child: new Text("Booked",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0),
                    child: new Text("Malam",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              new Opacity(
                  opacity: _opacity,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0),
                    child: new Text("Booked",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _openDetailTgl(DateTime tgl) {
    setState(() {
      _tgl = tgl;
      _opacity = 0.0;
      for (var i = 0; i < listBooked.length; i++) {
        String day = listBooked[i].day.toString();
        if (tgl.day.toString() == day) {
          _opacity = 1.0;
        }
      }
    });
  }

  String _convertBulan(int month) {
    String bulan = "";
    if (1 == month) {
      bulan = "Januari";
    } else if (2 == month) {
      bulan = "Februari";
    } else if (3 == month) {
      bulan = "Maret";
    } else if (4 == month) {
      bulan = "April";
    } else if (5 == month) {
      bulan = "Mei";
    } else if (6 == month) {
      bulan = "Juni";
    } else if (7 == month) {
      bulan = "Juli";
    } else if (8 == month) {
      bulan = "Agustus";
    } else if (9 == month) {
      bulan = "September";
    } else if (10 == month) {
      bulan = "Oktober";
    } else if (11 == month) {
      bulan = "November";
    } else if (12 == month) {
      bulan = "Desember";
    }
    return bulan;
  }
}
