import 'package:bride_story/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';
import '../models/category_model.dart';
import 'dart:async';

class SearchCategoryPage extends StatefulWidget {
  @override
  _SearchCategoryPageState createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  SharedPreferences sharedPreferences;
  List<CategoryModel> listCategories = new List<CategoryModel>();
  bool _loading = false;

  void _populateCategoryData(List<dynamic> listCategory) {
    for (var items in listCategory) {
      //iterate over the list
      Map category = items; //store each map
      // print(category['categoryName']);
      listCategories.add(new CategoryModel(category['categoryName'],
          category['categoryId'], category['selected']));
    }    
    // listCategories.add(new CategoryModel("Jewelry", false));
  }

  // hapus semua category yang dipilih
  void clearSelected() {
    for (var item in listCategories) {
      item.selected = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpServices http = new HttpServices();
    http.getCategories().then((List<dynamic> listCategory) {
      setState(() {
        _loading = false;
        _populateCategoryData(listCategory);
        getCategoryNameFromSharedPreferences(keyFilterParam)
            .then((String json) {
          setState(() {
            updateCategoryName(json);
          });
        });
      });
    });
  }

  List<Widget> _buildCategory() {
    Form form = new Form(
      child: new ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: listCategories.length,
        itemBuilder: (BuildContext context, int index) {
          if (listCategories.elementAt(index).selected == true) {
            return _buildRowSelected(context, index);
          } else {
            return _buildRow(context, index);
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

  _onTap(BuildContext context, selectedCategory, categoryId, int index) {
    setState(() {
      clearSelected();
      listCategories.elementAt(index).selected = true;
    });

    getCategoryNameFromSharedPreferences(keyFilterParam).then((String json) {
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(json);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);
      filterParamNew.categoryName = selectedCategory;
      filterParamNew.categoryId = categoryId;
      const JsonEncoder encoder = const JsonEncoder();
      String stringJson = encoder.convert(filterParamNew);
      saveCategoryNameInSharedPreferences(stringJson, keyFilterParam);
      Navigator.pop(context, selectedCategory);
    });
  }

  Widget _buildRow(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new Container(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: new ListTile(
                onTap: () {
                  _onTap(context, listCategories.elementAt(index).categoryName,
                      listCategories.elementAt(index).categoryId, index);
                },
                title: new Text(listCategories.elementAt(index).categoryName),
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
                  _onTap(context, listCategories.elementAt(index).categoryName,
                      listCategories.elementAt(index).categoryId, index);
                },
                title: new Text(listCategories.elementAt(index).categoryName),
                trailing: Icon(Icons.check),
              ),
            )),
        new Divider(
          height: 2.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Search Category"),
        ),
        // body: _buildCategory(),
        body: new Stack(
          children: _buildCategory(),
        ),
      ),
    );
  }

  void saveCategoryNameInSharedPreferences(
      String categoryName, String key) async {
    print("save category name " + categoryName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, categoryName);
  }

  Future<String> getCategoryNameFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categoryName = "";
    categoryName = (prefs.getString(key) ?? "");
    print("get from shared Preferenced " + categoryName);
    return categoryName;
  }

  void updateCategoryName(String categoryName) {
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(categoryName);
    var filterParamNew = new FilterParam.fromJson(filterParamMap);
    for (var item in listCategories) {
      if (item.categoryName == filterParamNew.categoryName) {
        clearSelected();
        listCategories.elementAt(listCategories.indexOf(item)).selected = true;
        break;
      }
    }
  }
}
