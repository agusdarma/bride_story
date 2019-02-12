import 'dart:convert';

import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/result_search_model.dart';
import 'package:bride_story/models/venue_model.dart';
import 'package:bride_story/plugins/components/BuildingDetails.dart';
import 'package:bride_story/plugins/components/ProductDetails.dart';
import 'package:bride_story/plugins/components/Sort.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/theme/style.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style.dart';
import 'package:flutter/foundation.dart';


class ProductList extends StatefulWidget {
  final List<PageNew> allPages;
  final FilterParam parameter;

  ProductList({Key key, this.allPages,
    this.parameter}) : super(key: key);
  @override
  ProductListState createState() => new ProductListState(allPages, parameter);
  static String tag = 'ProductList';
}

class ProductListState extends State<ProductList>
    with TickerProviderStateMixin {
  ProductListState(this.allPages, this.parameter);
  final formatter = new NumberFormat("#,###");
  List<PageNew> allPages;
  FilterParam parameter;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new SortData();
        });
  }

  String text = "Loading";
  List<ResultSearchModel> listResultData = new List<ResultSearchModel>();
  List<VenueModel> listVenueData = new List<VenueModel>();
  FilterParam filterParamNew;
  int selectedDate = new DateTime.now().millisecondsSinceEpoch;
  String displayedDate = "";
  String countSearch = "0";

  void _populateResultData(List<dynamic> listVenue) {
    for (var items in listVenue) {
      Map venue = items; //store each map
      Map venue2 = venue['venue'];
      List<dynamic> listBookingDate = venue['listBookingDates'];
      int isDay;
      int isNight;
      int isDayFlag;
      int isNightFlag;
      int bookingDateVal;
      for (var bookingDate in listBookingDate) {
        if (bookingDate['bookingDate'] == parameter.bookingDate) {
          isDay = bookingDate['isDay'];
          isNight = bookingDate['isNight'];
          isDayFlag = bookingDate['isDay'];
          isNightFlag = bookingDate['isNight'];
          bookingDateVal = bookingDate['bookingDate'];
        } else {
          isDay = bookingDate['isDay'];
          isNight = bookingDate['isNight'];
          // isDayFlag = bookingDate['isDay'];
          // isNightFlag = bookingDate['isNight'];
          bookingDateVal = bookingDate['bookingDate'];
        }
      }
      int id = venue2['id'];
      String linkImageVenue = venue2['linkImageVenue'];
      String titleVenue = venue2['titleVenue'];
      String addressVenue = venue2['addressVenue'];
      String capacityVisitor = venue2['capacityVisitor'];
      String capacityParkir = venue2['capacityParkir'];
      String luasBangunan = venue2['luasBangunan'];
      String luasTanah = venue2['luasTanah'];
      String hargaVenue = formatter.format(int.parse(venue2['hargaVenue']));
      int idCity = venue2['idCity'];
      double latitude = venue2['latitude'];
      double longitude = venue2['longitude'];
      String locationVenue = venue2['locationVenue'];
      listVenueData.add(new VenueModel(
          id,
          linkImageVenue,
          titleVenue,
          addressVenue,
          capacityVisitor,
          capacityParkir,
          luasBangunan,
          luasTanah,
          hargaVenue,
          idCity,
          locationVenue,
          isDay,
          isNight,
          isDayFlag,
          isNightFlag,
          bookingDateVal,
          listBookingDate,
          latitude,
          longitude));
    }
    // print(listVenueData.length);
  }

  void _updateBookingDate(List<VenueModel> listVenue) {
    for (var items in listVenue) {
      for (var bookingDate in items.listBookingDate) {
        // items.isDayFlag = 0;
        // items.isNightFlag = 0;
        if (bookingDate['bookingDate'] == parameter.bookingDate) {
          items.isDayFlag = bookingDate['isDay'];
          items.isNightFlag = bookingDate['isNight'];
          break;
        } else {
          items.isDayFlag = 0;
          items.isNightFlag = 0;
        }
        // if (items.bookingDate == parameter.bookingDate) {
        //   items.isDayFlag = items.isDay;
        //   items.isNightFlag = items.isNight;
        // } else {
        //   items.isDayFlag = 0;
        //   items.isNightFlag = 0;
        // }
      }
    }
  }

  Future<String> _getFilterParam(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = (prefs.getString(key) ?? "");
    // print("get from shared Preferenced " + json);
    return json;
  }

  String _convertBulan(int month) {
    String bulan = "";
    if (1 == month) {
      bulan = januari;
    } else if (2 == month) {
      bulan = februari;
    } else if (3 == month) {
      bulan = maret;
    } else if (4 == month) {
      bulan = april;
    } else if (5 == month) {
      bulan = mei;
    } else if (6 == month) {
      bulan = juni;
    } else if (7 == month) {
      bulan = juli;
    } else if (8 == month) {
      bulan = agustus;
    } else if (9 == month) {
      bulan = september;
    } else if (10 == month) {
      bulan = oktober;
    } else if (11 == month) {
      bulan = november;
    } else if (12 == month) {
      bulan = desember;
    }
    return bulan;
  }

  @override
  void initState() {
    super.initState();
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(parameter);
    http.getAllVenueWithParam(parameterJson).then((List<dynamic> listVenue) {
      setState(() {
        // _generateCarouselWidget(listVenue);
        _populateResultData(listVenue);
        countSearch = listVenue.length.toString();
      });
    });

    setState(() {
      displayedDate = '28 Agustus 2018';
      if (parameter.bookingDate != null) {
        int bookingDate = parameter.bookingDate;
        int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
        int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
        int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
        displayedDate =
            day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
      }

      _getFilterParam(keyFilterParam).then((result) {
        setState(() {
          updateSubtitle(result);
        });
      });
    });
  }

  Future updateSubtitle(String json) async {
    // print(json);
    // await new Future.delayed(const Duration(seconds: 2));
    const JsonDecoder decoder = const JsonDecoder();
    Map filterParamMap = decoder.convert(json);
    filterParamNew = new FilterParam.fromJson(filterParamMap);
    setState(() {
      text = "Search result for " +
          filterParamNew.categoryName +
          " in " +
          filterParamNew.cityName +
          " ," +
          filterParamNew.countryName;
      // _populateResultData();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgetBuilding = <Widget>[];

    for (var venue in listVenueData) {
      String fileName = venue.linkImageVenue;
      String url = HttpServices.getImageByName +
          kParamImageName.replaceAll('<img>', '$fileName');
      listWidgetBuilding.add(new BuildingDetails(name: venue.titleVenue, picture: url, capacityVisitor: venue.capacityVisitor, capacityParkir: venue.capacityParkir, hargaVenue: venue.hargaVenue,));
    } // for

    double _height = MediaQuery.of(context).size.height - 156.0;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
//    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: new Text(
          "Building List",
          style: textStylew600,
        ),
        actions: <Widget>[
          new Icon(
            Icons.search,
            color: Colors.black,
            size: 25.0,
          ),
        ],
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.black,
            ),
            onPressed: () {
//              Navigator.of(context).pushNamed("/product");
              Navigator.of(context).pop();
            }),
      ),
      body: new Container(
        height: _height,
        child: new Scrollbar(
          child: new GridView.count(
            scrollDirection: Axis.vertical,
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: const EdgeInsets.all(2.0),
            children: listWidgetBuilding,
          ),
        )
    )
//      bottomNavigationBar: new HomeWithTab(),
    );
  }
}
