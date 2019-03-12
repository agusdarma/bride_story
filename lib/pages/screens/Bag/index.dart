import 'package:flutter/material.dart';
import 'package:bride_story/theme/style.dart';
import 'style.dart';
import 'package:bride_story/plugins/components/CustomCard.dart';
import 'package:bride_story/plugins/components/CustomCardAmount.dart';
import 'package:bride_story/plugins/components/BagCard.dart';
import 'package:flutter/foundation.dart';
import 'package:bride_story/plugins/components/Bagwishlist.dart';
import 'package:bride_story/plugins/components/Buttons/commonsaveButton.dart';
import 'package:bride_story/plugins/components/BottomNavigation/BagNavigation.dart';

class Bag extends StatefulWidget {
  Bag({Key key}) : super(key: key);
  @override
  BagState createState() => new BagState();
}

class BagState extends State<Bag> with TickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: new Text(
          " Form Konfirmasi",
          style: textStylew600,
        ),
      ),
      body: new ListView(
        padding: const EdgeInsets.only(
            left: 12.0, top: 10.0, bottom: 10.0, right: 12.0),
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'ITEMS (1)',
                style: textStylesubTitle,
              ),
              new Text(
                'TOTAL: Rp. 30.000.000',
                style: textStylesubTitle,
              ),
            ],
          ),
          new Card(
            child: new Padding(
              padding: const EdgeInsets.only(
                  left: 2.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: new Column(
                children: <Widget>[
                  new BagCard(
                    picture: bag1,
                    text: 'Balai Samudra',
                    text1: 'Waktu : Malam ( 19:00 - 21:00 )',
                    text2: '- Ruang Makeup untuk pengantin',
                    text3: '- Ruang Makeup untuk wanita',
                    text4: '- Ruang Makeup untuk pria',
                    text5: '- Akad Nikah',
                  ),
//                  new BagWishlist(
//                    text: 'REMOVE',
//                    text1: '|',
//                    text2: 'MOVE TO WISHLIST',
//                  ),
                ],
              ),
            ),
          ),
//          new Card(
//            child: new Padding(
//              padding: const EdgeInsets.only(
//                  left: 2.0, top: 0.0, bottom: 10.0, right: 0.0),
//              child: new Column(
//                children: <Widget>[
//                  new BagCard(
//                    picture: bag1,
//                    text: 'FabAlley Women Gray Classic Fit',
//                    text1: 'Casual Top',
//                    text2: 'Sold by: Funfash',
//                    text3: 'Only 1 unit in Stock',
//                    text4: '\$1299',
//                    text5: '\$799',
//                  ),
//                  new BagWishlist(
//                    text: 'REMOVE',
//                    text1: '|',
//                    text2: 'MOVE TO WISHLIST',
//                  ),
//                ],
//              ),
//            ),
//          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, bottom: 0.0, right: 2.0),
            child: new Text(
              "OPTIONS",
              style: textStylesubTitle,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new CustomCard(
                    icon: Icons.settings,
                    text: "Apply Coupon",
                    trailingIcon: Icons.arrow_forward_ios,
                  ),
//                  new CustomCard(
//                    icon: Icons.card_giftcard,
//                    text: "Gift Wrap for \$25",
//                    trailingIcon: Icons.arrow_forward_ios,
//                  ),
                ],
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 5.0, top: 10.0, bottom: 0.0, right: 2.0),
            child: new Text(
              "PAYMENTS DETAILS",
              style: textStylesubTitle,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 10.0, bottom: 0.0, right: 0.0),
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new CustomCardAmount(
                    text: "Total",
                    text1: "Rp 30.000.000",
                    color: const Color.fromRGBO(85, 85, 85, 1.0),
                    fontWeight: FontWeight.w300,
                  ),
                  new CustomCardAmount(
                    text: "Discount",
                    text1: " Rp 1000.000 ",
                    color: textFieldColor,
                    fontWeight: FontWeight.normal,
                  ),
                  new CustomCardAmount(
                    text: "Sub Total",
                    text1: "Rp 29.000.000",
                    color: const Color.fromRGBO(85, 85, 85, 1.0),
                    fontWeight: FontWeight.w300,
                  ),
//                  new CustomCardAmount(
//                    text: "Coupon Discount",
//                    text1: "0",
//                    color: const Color.fromRGBO(85, 85, 85, 1.0),
//                    fontWeight: FontWeight.w300,
//                  ),
                  new CustomCardAmount(
                    text: "Total Payable",
                    text1: "Rp 29.000.000              ",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          new SaveButton(
            text: "BOOKING VENUE",
            text1: "/address",
          ),
        ],
      ),
//      bottomNavigationBar: new HomeWithTab(),
    );
  }
}
