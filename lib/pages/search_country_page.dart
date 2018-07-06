import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';

class SearchCountryPage extends StatefulWidget {
  @override
  _SearchCountryPageState createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  SharedPreferences sharedPreferences;
  List<String> listCountry = new List<String>();

  /*
for demo hardcode
 */
  void _populateCountryData() {
    listCountry.add("Indonesia");
    listCountry.add("All Countries");
    listCountry.add("Albania");
    listCountry.add("Angola");
    listCountry.add("Antigua");
    listCountry.add("Argentina");
    listCountry.add("Aruba");
    listCountry.add("Australia");
    listCountry.add("Austria");
    listCountry.add("Bahamas");
    listCountry.add("Bahrain");
    listCountry.add("Barbados");
    listCountry.add("Cambodia");
    listCountry.add("Denmark");
    listCountry.add("Eqypt");
    listCountry.add("Fiji");
    listCountry.add("Germany");    
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _populateCountryData();
    });
  }

  Widget _buildCountry() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listCountry.length,
      itemBuilder: (BuildContext context, int index) {        
      return _buildRow(context, index);
      },
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: new ListTile(
            onTap: () {
              _onTap(context, listCountry[index]);
            },
            title: new Text(listCountry[index]),
          ),
        ));
  }

  _onTap(BuildContext context, selectedCountry) async {
    sharedPreferences = await SharedPreferences.getInstance();      
    String filterParam = sharedPreferences.getString(keyFilterParam);
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(filterParam);
    var filterParamNew = new FilterParam.fromJson(filterParamMap);
    filterParamNew.countryName = selectedCountry;
    const JsonEncoder encoder = const JsonEncoder();
    String stringJson = encoder.convert(filterParamNew);    
    sharedPreferences.setString(keyFilterParam, stringJson);   
    Navigator.pop(context, selectedCountry);
  }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Search Country"),
        ),
        body: _buildCountry(),
      ),
    );
  }
}