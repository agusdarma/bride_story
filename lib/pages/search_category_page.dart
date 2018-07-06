import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';

class SearchCategoryPage extends StatefulWidget {
  
  @override
  _SearchCategoryPageState createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  SharedPreferences sharedPreferences;
  List<String> listCategory = new List<String>();

/*
for demo hardcode
 */
  void _populateCategoryData() {
    listCategory.add("All Category");
    listCategory.add("Bridal");
    listCategory.add("Catering");
    listCategory.add("Dance & Choreography");
    listCategory.add("Decoration & Lighting");
    listCategory.add("Dress & Attire");
    listCategory.add("Entertainment (MC)");
    listCategory.add("Entertainment (DJ)");
    listCategory.add("Entertainment (Music)");
    listCategory.add("Event Rentals");
    listCategory.add("Favors & Gifts");
    listCategory.add("Flowers");
    listCategory.add("Hair & Makeup");
    listCategory.add("Health & Beauty");
    listCategory.add("Honeymoon");
    listCategory.add("Invitation");
    listCategory.add("Invitation");
    listCategory.add("Invitation");
    listCategory.add("Invitation");
    listCategory.add("Invitation");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _populateCategoryData();
    });
  }

  Widget _buildCategory() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listCategory.length,
      itemBuilder: (BuildContext context, int index) {
        // if (index.isOdd) return new Divider(color: Colors.black, height: 1.0);
        return _buildRow(context, index);
      },
    );
  }

  _onTap(BuildContext context, selectedCategory) async {
    sharedPreferences = await SharedPreferences.getInstance();      
    FilterParam filterParam = new FilterParam(selectedCategory,"","");
    // encode to string json
    const JsonEncoder encoder = const JsonEncoder();
    String stringJson = encoder.convert(filterParam);
    print(stringJson);

    // decode from string json to object
    // const JsonDecoder decoder = const JsonDecoder();
    // Map filterParamMap = decoder.convert(stringJson);
    // var filterParamNew = new FilterParam.fromJson(filterParamMap);
    // filterParamNew.cityName = "agus";
    // print(filterParamNew.toString());

    // set ke shared preference
    sharedPreferences.setString(keyFilterParam, stringJson);   

    // get dari shared preference
    // String pref = sharedPreferences.getString(keyFilterParam);   
    // print(pref);  

    // final snackBar = SnackBar(content: Text(selectedCategory));
    // Scaffold.of(context).showSnackBar(snackBar);
    Navigator.pop(context, '/');
  }

  Widget _buildRow(BuildContext context, int index) {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: new ListTile(
            onTap: () {
              _onTap(context, listCategory[index]);
            },
            title: new Text(listCategory[index]),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Search Category"),
        ),
        body: _buildCategory(),
      ),
    );
  }
}
