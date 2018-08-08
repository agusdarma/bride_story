import 'dart:async';

import 'package:bride_story/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../models/country_model.dart';
import '../utils/constant.dart';
import 'dart:convert';

class SearchCountryPage extends StatefulWidget {
  @override
  _SearchCountryPageState createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  SharedPreferences sharedPreferences;
  // List<String> listCountry = new List<String>();
  List<CountryModel> listCountries = new List<CountryModel>();
  bool _loading = false;

  /*
for demo hardcode
 */
  void _populateCountryData(List<dynamic> listCountry) {
    for (var items in listCountry) {
      //iterate over the list
      Map country = items; //store each map
      // print(category['categoryName']);
      listCountries.add(new CountryModel(
          country['countryName'], country['selected'], country['countryId']));
    }

    // listCountries.add(new CountryModel("Indonesia", true));
  }

  void _updateCountryData(List<dynamic> listCountry) {
    if (listCountry.length > 0) {
      listCountries.clear();
    }
    for (var items in listCountry) {
      Map country = items;
      listCountries.add(new CountryModel(
          country['countryName'], country['selected'], country['countryId']));
    }
  }

  void checkAlreadySelected() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String pref = sharedPreferences.getString(keyFilterParam);
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(pref);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);

      for (var item in listCountries) {
        if (item.countryName == filterParamNew.countryName) {
          setState(() {
            clearSelected();
            listCountries.elementAt(listCountries.indexOf(item)).selected =
                true;
          });
          break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // hapus semua category yang dipilih
  void clearSelected() {
    for (var item in listCountries) {
      item.selected = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpServices http = new HttpServices();
    http.getCountry().then((List<dynamic> listCountry) {
      setState(() {
        _loading = false;
        _populateCountryData(listCountry);
        getCountryNameFromSharedPreferences(keyFilterParam).then((String json) {
          setState(() {
            updateCountryName(json);
          });
        });
      });
    });
  }

  _searchCountryByParam(String param) {
    // print("Second text field: ${param}");
    setState(() {
      _loading = true;
    });
    HttpServices http = new HttpServices();
    http.getCountryWithParam(param).then((List<dynamic> listCountry) {
      setState(() {
        _loading = false;
        print(listCountry);
        _updateCountryData(listCountry);
      });
    });
  }

  List<Widget> _buildCountry() {
    Form form = new Form(
      child: new ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: listCountries.length,
        itemBuilder: (BuildContext context, int index) {
          // // cek apakah kategori dipilih atau tidak karena memiliki view beda
          if (listCountries.elementAt(index).selected == true) {
            // return new Column(
            //   children: <Widget>[_buildRowSelected(context, index)],
            // );
            if (index == 0) {
              return new Column(
                children: <Widget>[
                  new Container(
                    color: Colors.grey[150],
                    child: new ListTile(
                      leading: const Icon(Icons.search),
                      title: new TextField(
                        onChanged: (text) {
                          _searchCountryByParam(text);
                        },
                        decoration: new InputDecoration(
                          hintText: "Search Select Country",
                        ),
                      ),
                    ),
                  ),
                  _buildRowSelected(context, index)
                ],
              );
            } else {
              return new Column(
                children: <Widget>[_buildRowSelected(context, index)],
              );
            }
          } else {
            if (index == 0) {
              return new Column(
                children: <Widget>[
                  new Container(
                    color: Colors.grey[150],
                    child: new ListTile(
                      leading: const Icon(Icons.search),
                      title: new TextField(
                        onChanged: (text) {
                          _searchCountryByParam(text);
                        },
                        decoration: new InputDecoration(
                          hintText: "Search Select Country",
                        ),
                      ),
                    ),
                  ),
                  _buildRow(context, index)
                ],
              );
            } else {
              return new Column(
                children: <Widget>[_buildRow(context, index)],
              );
            }
          }
        },
      ),
    );
    var l = new List<Widget>();
    l.add(form);
    if (_loading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.white),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }

  Widget _buildRow(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: new ListTile(
                onTap: () {
                  _onTap(context, listCountries.elementAt(index).countryName,
                      listCountries.elementAt(index).countryId, index);
                },
                title: new Text(listCountries.elementAt(index).countryName),
              ),
            )),
        new Divider(
          height: 2.0,
        )
      ],
    );
  }

  Widget _buildRowSelected(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: new ListTile(
                onTap: () {
                  _onTap(context, listCountries.elementAt(index).countryName,
                      listCountries.elementAt(index).countryId, index);
                },
                title: new Text(listCountries.elementAt(index).countryName),
                trailing: Icon(Icons.check),
              ),
            )),
        new Divider(
          height: 2.0,
        )
      ],
    );
  }

  _onTap(BuildContext context, selectedCountry, countryId, int index) async {
    setState(() {
      clearSelected();
      listCountries.elementAt(index).selected = true;
    });

    getCountryNameFromSharedPreferences(keyFilterParam).then((String json) {
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(json);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);
      filterParamNew.countryName = selectedCountry;
      filterParamNew.countryId = countryId;
      const JsonEncoder encoder = const JsonEncoder();
      String stringJson = encoder.convert(filterParamNew);
      savCountryNameInSharedPreferences(stringJson, keyFilterParam);
      Navigator.pop(context, selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Search Country"),
        ),
        // body: _buildCountry(),
        body: new Stack(
          children: _buildCountry(),
        ),
      ),
    );
  }

  void savCountryNameInSharedPreferences(String countryName, String key) async {
    print("save country name " + countryName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, countryName);
  }

  Future<String> getCountryNameFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String countryName = "";
    countryName = (prefs.getString(key) ?? "");
    print("get from shared Preferenced " + countryName);
    return countryName;
  }

  void updateCountryName(String countryName) {
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(countryName);
    var filterParamNew = new FilterParam.fromJson(filterParamMap);
    for (var item in listCountries) {
      if (item.countryName == filterParamNew.countryName) {
        clearSelected();
        listCountries.elementAt(listCountries.indexOf(item)).selected = true;
        break;
      }
    }
  }
}
