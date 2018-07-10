import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';
import '../models/result_search_model.dart';
import 'dart:ui';

class VendorPage extends StatefulWidget {
  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          title: new TextField(
            decoration:
                new InputDecoration(hintText: "Search Vendors, Articles Here"),
          ),
        ),
        body:
            // new Column(
            // children: <Widget>[
            new Stack(
          children: <Widget>[
            new Container(
              height: screenHeight / 3,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: new BackdropFilter(
                  filter: new ImageFilter.blur(
                    sigmaX: 3.0,
                    sigmaY: 3.0,
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  )),
            )
          ],
        ),
        // ],
        // ),
      ),
    );
  }
}
