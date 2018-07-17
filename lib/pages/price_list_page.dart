import 'package:flutter/material.dart';

class PriceListPage extends StatefulWidget {
  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> {
  String _description = "";
  @override
  Widget build(BuildContext context) {
    String composeDesc(){
        _description = "Price Range \n";
        _description = _description+"Start From IDR 6.500.000 / 3 hours \n\n";
        _description = _description+"3 Musicians & Music Instruments: \n";
        _description = _description+"- One Singer (Female/Male) \n";
        _description = _description+"- Pianist & Baby Grand Piano \n";
        _description = _description+"- Contrabassist & Contrabass \n\n";
        _description = _description+"High Quality Sound System 3.000 watt  \n";
        _description = _description+"- Mixer  \n";
        _description = _description+"- FOH Speakers  \n";
        _description = _description+"- Monitor Speakers  \n";
        _description = _description+"- Microphones  \n";
        _description = _description+"- CD Player  \n";
        _description = _description+"- Professional Sound Operator  \n";
        _description = _description+"- Sound Crews  \n";
        _description = _description+"- Transportation & Sound Installation  \n";
        _description = _description+"- 1 Assistant Manager  \n\n";
        _description = _description+"Setiap bulannya, Jova Musique ada PROMO DISCOUNT yang berbeda, please contact Mrs.Valentine 087885735546 untuk informasi promo lebih lanjut)  \n";
        _description = _description+"Sample Video: www.youtube.com/jovamusique (more than 700 videos)\n";
        
        return _description;
    }
    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("Price List")),
        body: new ListView(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // title
                new Container(
                  padding: EdgeInsets.only(left: 10.0,top: 10.0),
                  child: new Text("Wedding Package Silver",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),

                new Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Text(
                      composeDesc(),
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                ),
                // price
              ],
            )
          ],
        ),
      ),
    );
  }
}
