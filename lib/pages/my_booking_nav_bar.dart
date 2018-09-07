import 'package:flutter/material.dart';

class MyBookingPage extends StatefulWidget {
  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {

   @override
  void initState() {
    super.initState();
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
                  itemCount: 4,
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
