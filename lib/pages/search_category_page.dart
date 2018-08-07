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

  void _populateCategoryData(List<dynamic> listCategory) {
    for (var items in listCategory) {
      //iterate over the list
      Map category = items; //store each map
      // print(category['categoryName']);
      listCategories.add(new CategoryModel(category['categoryName'],
          category['categoryId'], category['selected']));
    }
    // listCategories.add(new CategoryModel("All Categories", true));
    // listCategories.add(new CategoryModel("Bridal", false));
    // listCategories.add(new CategoryModel("Catering", false));
    // listCategories.add(new CategoryModel("Dance & Choreography", false));
    // listCategories.add(new CategoryModel("Decoration & Lighting", false));
    // listCategories.add(new CategoryModel("Dress & Attire", false));
    // listCategories.add(new CategoryModel("Entertainment (MC)", false));
    // listCategories.add(new CategoryModel("Entertainment (DJ)", false));
    // listCategories.add(new CategoryModel("Entertainment (Music)", false));
    // listCategories.add(new CategoryModel("Event Rentals", false));
    // listCategories.add(new CategoryModel("Favors & Gifts", false));
    // listCategories.add(new CategoryModel("Flowers", false));
    // listCategories.add(new CategoryModel("Hair & Makeup", false));
    // listCategories.add(new CategoryModel("Health & Beauty", false));
    // listCategories.add(new CategoryModel("Honeymoon", false));
    // listCategories.add(new CategoryModel("Invitation", false));
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

    HttpServices http = new HttpServices();
    http.getCategories().then((List<dynamic> listCategory) {
      setState(() {
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

  Widget _buildCategory() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listCategories.length,
      itemBuilder: (BuildContext context, int index) {
        if (listCategories.elementAt(index).selected == true) {
          return _buildRowSelected(context, index);
        } else {
          return _buildRow(context, index);
        }
      },
    );
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
        body: _buildCategory(),
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
