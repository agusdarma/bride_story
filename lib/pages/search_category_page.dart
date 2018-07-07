import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/filter_param.dart';
import '../utils/constant.dart';
import 'dart:convert';
import '../models/category_model.dart';

class SearchCategoryPage extends StatefulWidget {
  @override
  _SearchCategoryPageState createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  SharedPreferences sharedPreferences;
  // List<String> listCategory = new List<String>();
  List<CategoryModel> listCategories = new List<CategoryModel>();

/*
for demo hardcode
 */
  void _populateCategoryData() {
    listCategories.add(new CategoryModel("All Categories", true));
    listCategories.add(new CategoryModel("Bridal", false));
    listCategories.add(new CategoryModel("Catering", false));
    listCategories.add(new CategoryModel("Dance & Choreography", false));
    listCategories.add(new CategoryModel("Decoration & Lighting", false));
    listCategories.add(new CategoryModel("Dress & Attire", false));
    listCategories.add(new CategoryModel("Entertainment (MC)", false));
    listCategories.add(new CategoryModel("Entertainment (DJ)", false));
    listCategories.add(new CategoryModel("Entertainment (Music)", false));
    listCategories.add(new CategoryModel("Event Rentals", false));
    listCategories.add(new CategoryModel("Favors & Gifts", false));
    listCategories.add(new CategoryModel("Flowers", false));
    listCategories.add(new CategoryModel("Hair & Makeup", false));
    listCategories.add(new CategoryModel("Health & Beauty", false));
    listCategories.add(new CategoryModel("Honeymoon", false));
    listCategories.add(new CategoryModel("Invitation", false));
    listCategories.add(new CategoryModel("Jewelry", false));
  }

  void checkAlreadySelected() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String pref = sharedPreferences.getString(keyFilterParam);
      const JsonDecoder decoder = const JsonDecoder();
      Map filterParamMap = decoder.convert(pref);
      var filterParamNew = new FilterParam.fromJson(filterParamMap);

      for (var item in listCategories) {
        if (item.categoryName == filterParamNew.categoryName) {
          setState(() {
            clearSelected();
            listCategories.elementAt(listCategories.indexOf(item)).selected =
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
    for (var item in listCategories) {
      item.selected = false;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // populate data kategory
      _populateCategoryData();
      // cek apakah kategori sudah  pernah dipilih sebelumnya dari shared preference
      checkAlreadySelected();
    });
  }

  Widget _buildCategory() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listCategories.length,
      itemBuilder: (BuildContext context, int index) {
        // if (index.isOdd) return new Divider(color: Colors.black, height: 1.0);
        // cek apakah kategori dipilih atau tidak karena memiliki view beda
        if (listCategories.elementAt(index).selected == true) {
          return _buildRowSelected(context, index);
        } else {
          return _buildRow(context, index);
        }
      },
    );
  }

  _onTap(BuildContext context, selectedCategory, int index) async {
    setState(() {
      clearSelected();
      listCategories.elementAt(index).selected = true;
    });

    sharedPreferences = await SharedPreferences.getInstance();
    FilterParam filterParam = new FilterParam(selectedCategory, "", "");
    // encode to string json
    const JsonEncoder encoder = const JsonEncoder();
    String stringJson = encoder.convert(filterParam);
    // print(stringJson);

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
    Navigator.pop(context, selectedCategory);
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
                      index);
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
                      index);
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
}
