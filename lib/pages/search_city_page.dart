import 'dart:async';

import 'package:bride_story/data/global_param.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../models/city_model.dart';
import '../utils/constant.dart';
import 'dart:convert';

class SearchCityPage extends StatefulWidget {
  @override
  _SearchCityPageState createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  SharedPreferences sharedPreferences;
  List<CityModel> listCities = new List<CityModel>();
  var globalParam = new GlobalParam("", "");

  /*
for demo hardcode
 */
  void _populateCityData(List<dynamic> listCity) {
    for (var items in listCity) {
      Map city = items;
      listCities.add(
          new CityModel(city['cityName'], city['countryId'], city['selected']));
    }
    // listCities.add(new CityModel("Jakarta", true));
    // listCities.add(new CityModel("All Cities", false));
    // listCities.add(new CityModel("Aceh", false));
    // listCities.add(new CityModel("Ambon", false));
    // listCities.add(new CityModel("Bali", false));
    // listCities.add(new CityModel("Balikpapan", false));
    // listCities.add(new CityModel("Bandar Lampung", false));
    // listCities.add(new CityModel("Bandung", false));
    // listCities.add(new CityModel("Bangka Belitung", false));
    // listCities.add(new CityModel("Banjarbaru", false));
    // listCities.add(new CityModel("Cimahi", false));
    // listCities.add(new CityModel("Garut", false));
    // listCities.add(new CityModel("Jakarta", false));
    // listCities.add(new CityModel("Jambi", false));
    // listCities.add(new CityModel("Kupang", false));
    // listCities.add(new CityModel("Lombok", false));
    // listCities.add(new CityModel("Medan", false));
  }

  void checkAlreadySelected() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String pref = sharedPreferences.getString(keyFilterParam);
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(pref);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);

      for (var item in listCities) {
        if (item.cityName == filterParamNew.cityName) {
          setState(() {
            clearSelected();
            listCities.elementAt(listCities.indexOf(item)).selected = true;
          });
          break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // hapus semua cities yang dipilih
  void clearSelected() {
    for (var item in listCities) {
      item.selected = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getCityNameFromSharedPreferences(keyFilterParam).then((String json) {
      setState(() {
        const JsonDecoder decoder = const JsonDecoder();
        Map filterParamMap = decoder.convert(json);
        var filterParamNew = new FilterParam.fromJson(filterParamMap);
        if (filterParamNew.countryName == "All Countries") {
          globalParam.countryId = "0";
        } else {
          globalParam.countryId = filterParamNew.countryId.toString();
        }
      });

      HttpServices http = new HttpServices();
      const JsonEncoder encoder = const JsonEncoder();
      String globalParamJson = encoder.convert(globalParam);
      http
          .getCityWithCountryId(globalParamJson)
          .then((List<dynamic> listCities) {
        setState(() {
          _populateCityData(listCities);
          getCityNameFromSharedPreferences(keyFilterParam).then((String json) {
            setState(() {
              updateCityName(json);
            });
          });
        });
      });
    });
  }

  _searchCityByParam(String param) {
    globalParam.param = param;
    const JsonEncoder encoder = const JsonEncoder();
    String globalParamJson = encoder.convert(globalParam);
    print("Second text field: ${globalParamJson}");
    HttpServices http = new HttpServices();
    http.getCityWithCountryId(globalParamJson).then((List<dynamic> listCity) {
      setState(() {
        print(listCity);
        _updateCityData(listCity);
      });
    });
  }

  Widget _buildCity() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listCities.length,
      itemBuilder: (BuildContext context, int index) {
        // cek apakah kategori dipilih atau tidak karena memiliki view beda
        if (listCities.elementAt(index).selected == true) {
          if (index == 0) {
            return new Column(
              children: <Widget>[
                new Container(
                  color: Colors.grey[150],
                  child: new ListTile(
                    leading: const Icon(Icons.search),
                    title: new TextField(
                      onChanged: (text) {
                        _searchCityByParam(text);
                      },
                      decoration: new InputDecoration(
                        hintText: "Search Select City",
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
                        _searchCityByParam(text);
                      },
                      decoration: new InputDecoration(
                        hintText: "Search Select City",
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
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: new ListTile(
                onTap: () {
                  _onTap(context, listCities.elementAt(index).cityName, index);
                },
                title: new Text(listCities.elementAt(index).cityName),
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
                  _onTap(context, listCities.elementAt(index).cityName, index);
                },
                title: new Text(listCities.elementAt(index).cityName),
                trailing: Icon(Icons.check),
              ),
            )),
        new Divider(
          height: 2.0,
        )
      ],
    );
  }

  _onTap(BuildContext context, selectedCity, int index) async {
    setState(() {
      clearSelected();
      listCities.elementAt(index).selected = true;
    });

    getCityNameFromSharedPreferences(keyFilterParam).then((String json) {
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(json);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);
      filterParamNew.cityName = selectedCity;
      const JsonEncoder encoder = const JsonEncoder();
      String stringJson = encoder.convert(filterParamNew);
      saveCityNameInSharedPreferences(stringJson, keyFilterParam);
      Navigator.pop(context, selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Search City"),
        ),
        body: _buildCity(),
      ),
    );
  }

  void saveCityNameInSharedPreferences(String cityName, String key) async {
    print("save city name " + cityName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, cityName);
  }

  Future<String> getCityNameFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cityName = "";
    cityName = (prefs.getString(key) ?? "");
    print("get from shared Preferenced " + cityName);
    return cityName;
  }

  void updateCityName(String cityName) {
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(cityName);
    var filterParamNew = new FilterParam.fromJson(filterParamMap);
    for (var item in listCities) {
      if (item.cityName == filterParamNew.cityName) {
        clearSelected();
        listCities.elementAt(listCities.indexOf(item)).selected = true;
        break;
      }
    }
  }

  void _updateCityData(List<dynamic> listCity) {
    if (listCity.length > 0) {
      listCities.clear();
    }
    for (var items in listCity) {
      Map city = items;
      listCities.add(
          new CityModel(city['cityName'], city['countryId'], city['selected']));
    }
  }
}
