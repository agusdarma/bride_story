import 'package:flutter/material.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';

class PriceListPage extends StatefulWidget {
  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> {
  // String _description = "";
  @override
  Widget build(BuildContext context) {
    // String composeDesc() {
    //   _description = "Price Range \n";
    //   _description = _description + "Start From IDR 6.500.000 / 3 hours \n\n";
    //   _description = _description + "3 Musicians & Music Instruments: \n";
    //   _description = _description + "- One Singer (Female/Male) \n";
    //   _description = _description + "- Pianist & Baby Grand Piano \n";
    //   _description = _description + "- Contrabassist & Contrabass \n\n";
    //   _description = _description + "High Quality Sound System 3.000 watt  \n";
    //   _description = _description + "- Mixer  \n";
    //   _description = _description + "- FOH Speakers  \n";
    //   _description = _description + "- Monitor Speakers  \n";
    //   _description = _description + "- Microphones  \n";
    //   _description = _description + "- CD Player  \n";
    //   _description = _description + "- Professional Sound Operator  \n";
    //   _description = _description + "- Sound Crews  \n";
    //   _description = _description + "- Transportation & Sound Installation  \n";
    //   _description = _description + "- 1 Assistant Manager  \n\n";
    //   _description = _description +
    //       "Setiap bulannya, Jova Musique ada PROMO DISCOUNT yang berbeda, please contact Mrs.Valentine 087885735546 untuk informasi promo lebih lanjut)  \n";
    //   _description = _description +
    //       "Sample Video: www.youtube.com/jovamusique (more than 700 videos)\n";

    //   return _description;
    // }

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("Price List")),
        body:
            // _createContent(context),
            new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                _createContent(context),
                // _createContent(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createContent(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            begin: Alignment.bottomCenter,
            colors: [const Color(0xFFCCCCCC), const Color(0xFFFFFFFF)],
            end: Alignment.topCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated),
      ),
      child: new Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // new Text(
          //   'LOGO',
          //   style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          // ),
          // new Text(
          //   'version 1.0',
          //   style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          // ),
          new Container(
            // margin: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
            child: _dataAboutApplication(context),
          )
        ],
      ),
    );
  }

  Widget _dataAboutApplication(BuildContext context) {
    // String html = '<h4>Selamat datang di mBanking Telkomsel</h4></br>'
    //     '<div style="text-align: justify;margin-bottom:50px;">Aplikasi mBanking Telkomsel adalah sebuah aplikasi Telkomsel yang memiliki fungsi segala transaksi perbankan</div>'
    //     '<br /><p align="justify" style="text-align: justify;margin-top:50px;">Fitur mBanking Telkomsel antara lain :</p>'
    //     '<p>- Transaksi Perbankan</p>'
    //     '<p>- Promo Program</p>';
    String html2 = '<h1 style="text-align: right;">VENUE</h1>'
        '<h4 style="text-align: right;">INTIMATE WEDDING PACKAGE 2018 - SINGOSARI OR TIMOR ROOM</h4>'
'<p style="text-align: center;"><span class="price"><strong><span style="color: #ff99cc;">IDR&nbsp;238.000.000</span></strong>&nbsp;</span>/&nbsp;300 PAX</p>'
'<p style="text-align: center;">&nbsp;</p>'
'<h3 style="text-align: center;">HARMONY PACKAGE 2018 - SINGOSARI OR SUMBA ROOM</h3>'
'<p style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;388.000.000</span>&nbsp;</span>/&nbsp;500 PAX</p>'
'<p style="text-align: center;">&nbsp;</p>'
'<h3 style="text-align: center;">MELODY PACKAGE 2018 - SUMBA OR SINGOSARI &amp; POOLSIDE</h3>'
'<p style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;528.000.000</span>&nbsp;</span>/&nbsp;700 PAX</p>'
'<p style="text-align: center;">&nbsp;</p>'
'<div class="pl-package pb-40">'
'<h3 class="pl-title f-b-14" style="text-align: center;">SYMPHONY PACKAGE 2018 - FLORES BALLROOM</h3>'
'<div class="pl-price f-b-14 reg" style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;698.000.000</span>&nbsp;</span>/&nbsp;1000 PAX</div>'
'<div class="pl-description">&nbsp;</div>'
'</div>'
'<div class="pl-package pb-40">'
'<h3 class="pl-title f-b-14" style="text-align: center;">BOROBUDUR PACKAGE 2018 - FLORES BALLROOM &amp; TIMOR</h3>'
'<div class="pl-price f-b-14 reg" style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;968.000.000</span>&nbsp;</span>/&nbsp;1500 PAX</div>'
'<div class="pl-description">&nbsp;</div>'
'</div>'
'<div class="pl-package pb-40">'
'<h3 class="pl-title f-b-14" style="text-align: center;">SPECIAL DEAL WEDDING PACKAGE 200 PAX - 2018</h3>'
'<div class="pl-price f-b-14 reg" style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;108.000.000</span>&nbsp;</span>/&nbsp;200 PAX</div>'
'<div class="pl-description" style="text-align: center;">&nbsp;</div>'
'</div>'
'<div class="pl-package pb-40" style="text-align: center;">'
'<h3 class="pl-title f-b-14">SPECIAL DEAL WEDDING PACKAGE 500 PAX -2018</h3>'
'<div class="pl-price f-b-14 reg"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;258.000.000</span>&nbsp;</span>/&nbsp;500 PAX</div>'
'<div class="pl-description">&nbsp;</div>'
'</div>'
'<div class="pl-package pb-40">'
'<h3 class="pl-title f-b-14" style="text-align: center;">SPECIAL DEAL WEDDING PACKAGE 1000 PAX-2018</h3>'
'<div class="pl-price f-b-14 reg" style="text-align: center;"><span class="price"><span style="color: #ff99cc;">IDR&nbsp;488.000.000</span>&nbsp;</span>/&nbsp;1000 PAX</div>'
'</div>';
    // final file = new File('html_file/about.html');

    return new SingleChildScrollView(
      // child: new HtmlView(data: html2),
      child: new Text('data'),
    );
  }
}
