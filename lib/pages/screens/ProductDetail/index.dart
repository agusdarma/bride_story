import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/venue_model.dart';
import 'package:bride_story/pages/screens/Bag/index.dart';
import 'package:bride_story/pages/screens/ProductList/index.dart';
import 'package:bride_story/plugins/components/ProductDetailCard.dart';
import 'package:bride_story/plugins/components/ProductSizeCard.dart';
import 'package:bride_story/plugins/components/SizeCard.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:bride_story/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Details.dart';
import 'style.dart';

class ProductDetail extends StatefulWidget {
  final List<PageNew> allPages;
  final FilterParam parameter;
  final String name;
  final String pic;
  final VenueModel venueModel;

  ProductDetail({
    this.name,
    this.pic,
    this.allPages,
    this.parameter,
    this.venueModel
  });
  @override
  ProductDetailState createState() =>
      new ProductDetailState(name: name, pic: pic, allPages: allPages, parameter: parameter,venueModel: venueModel);
  static String tag = 'BuildingDetail';
}

enum MyDialogAction { yes }

class ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  final String name;
  final String pic;
  final VenueModel venueModel;
  final int countImage = 1;

  ProductDetailState({this.name, this.pic,this.allPages, this.parameter, this.venueModel});
  List<PageNew> allPages;
  FilterParam parameter;
  List<String> images = ["pic"];
  List<String> pages = ["Paket Detail", "Tentang Kami"];
  bool test = true;
  bool test1 = true;
  bool test2 = true;
  bool test3 = true;
  bool test4 = true;
  Animation<double> animation;
  AnimationController controller;


  GoogleMapController mapController;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 270.0,
        target: LatLng(venueModel.latitude, venueModel.longitude),
        tilt: 30.0,
        zoom: 17.0,
      ),
    ));
  }

  void changeState() {
    if (test1 && test2 && test3)
      setState(() {
        test = !test;
      });
    else {
      test = test;
    }
  }

  void changeState1() {
    if (test && test2 && test3)
      setState(() {
        test1 = !test1;
      });
    else {
      test1 = test1;
    }
  }

  void changeState2() {
    if (test && test1 && test3)
      setState(() {
        test2 = !test2;
      });
    else {
      test2 = test2;
    }
  }

  void changeState3() {
    if (test && test1 && test2)
      setState(() {
        test3 = !test3;
      });
    else {
      test3 = test3;
    }
  }

  void changeState4() {
    setState(() {
      test4 = !test4;
    });
  }

  void _dialogResult(MyDialogAction value) {
    Navigator.pop(context);
  }

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        "Please Select a Size",
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _dialogResult(MyDialogAction.yes);
          },
          child: new Text("OK!",
              style: new TextStyle(
                color: textFieldColor,
              )),
        )
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlert1() {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        venueModel.addressVenue,
        style: new TextStyle(fontSize: 18.0, color: Colors.black),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _dialogResult(MyDialogAction.yes);
          },
          child: new Text("OK!",
              style: new TextStyle(
                color: textFieldColor,
              )),
        )
      ],
    );
    showDialog(context: context, child: dialog);
  }

  _navigatelistBuilding(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ProductList(
            allPages: allPages,
            parameter: parameter,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = new TabController(length: 2, vsync: this);
    final TabController controller1 = new TabController(length: 2, vsync: this);

    Size screenSize = MediaQuery.of(context).size;

    Widget bannerMap = new Padding(
      padding: const EdgeInsets.only(top: 70.0, left: 120.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.yellow.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'Show Detail Map',
          style: TextStyle(
            // fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: new Text(
          "Building Detail",
          style: textStylew600,
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.black,
            ),
            onPressed: () {
//              Navigator.of(context).pushNamed("/productList");
              _navigatelistBuilding(context);
            }),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: backgroundImage),
            child: new Column(
              children: <Widget>[
                new Hero(
                  tag: name,
                  child: new Material(
                      child: new InkWell(
                    child: new Container(
                      decoration: new BoxDecoration(image: backgroundImage),
                      height: screenSize.height / 2.5,
                      child: new SizedBox(
                        height: 230.0,
                        child: new DefaultTabController(
                          length: countImage,
                          child: new Container(
                            child: new Stack(
                              children: <Widget>[
                                new TabBarView(
                                  children: images.map((String image) {
                                    return new GestureDetector(
                                      child: new Container(
                                        height: 260.0,
                                        padding: new EdgeInsets.only(
                                            top: 10.0,
                                            left: 10.0,
                                            right: 10.0,
                                            bottom: 20.0),
                                        child: new Image(
                                          image: new NetworkImage(pic),
                                          height: screenSize.height / 2.3,
                                          width: screenSize.width / 1.4,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  controller: controller,
                                ),
//                                new Container(
//                                  alignment: new FractionalOffset(0.5, 0.95),
//                                  child: new TabPageSelector(
//                                    controller: controller,
//                                    color: Colors.white,
//                                    selectedColor: Colors.grey,
//                                  ),
//                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
                new Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 10.0, top: 10.0, bottom: 5.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        name,
                        style: textStylew600,
                      )
                    ],
                  ),
                ),
                new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                          bottom: new BorderSide(
                        color: Colors.black26,
                      ))),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 0.0, top: 5.0, bottom: 5.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 5.0, bottom: 5.0, right: 10.0),
                        child: new Text(
                          venueModel.capacityParkir,
                          style: textPriceActual,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                        child: new Text(
                          venueModel.capacityVisitor,
                          style: textDescription,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 5.0, bottom: 5.0, right: 0.0),
                        child: new Text(
                          venueModel.hargaVenue,
                          style: textPriceActual,
                        ),
                      ),
                    ],
                  ),
                ),
                new ProductDetailCard(
                  icon: Icons.local_offer,
                  text: "Tap to get address info",
                  onPress: _showAlert1,
                ),
                new Container(
                  height: 500.0,
                  padding: const EdgeInsets.only(
                      left: 6.0, right: 10.0, top: 0.0, bottom: 0.0),
                  decoration: new BoxDecoration(image: backgroundImage),
                  child: new Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            new SizedBox(
                              width: 450.0,
                              height: 200.0,
                              child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    bearing: 270.0,
                                    target: LatLng(venueModel.latitude, venueModel.longitude),
                                    tilt: 10.0,
                                    zoom: 5.0,
                                  ),
//                                bearing: 270.0,
//                                target: LatLng(venueModel.latitude, venueModel.longitude),
//                                tilt: 30.0,
//                                zoom: 17.0,
                                  onMapCreated: _onMapCreated,
                              ),
                            ),
                            // GoogleMapOverlay(controller: previewMap),
                            bannerMap,
                          ],
                        ),
                        onTap: () {
//                          _navigateMapsDetailPage(context, allPages[0], venueModel);
                        },
                      ),
                      new ProductSizeCard(
                        icon: Icons.access_time,
                        text: 'Jam',
                        text1: "Siang / Malam",
                      ),
                      new Container(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0,
                                  top: 3.0,
                                  bottom: 5.0,
                                  right: 10.0),
                              child: new SizeCard(
                                text: "Siang",
                                color: (test ? indicatorColor : Colors.green),
                                changstate: changeState,
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0,
                                  top: 3.0,
                                  bottom: 5.0,
                                  right: 10.0),
                              child: new SizeCard(
                                text: "Malam",
                                color: (test1 ? indicatorColor : Colors.green),
                                changstate: changeState1,
                              ),
                            ),
//                            new Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 0.0,
//                                  top: 3.0,
//                                  bottom: 5.0,
//                                  right: 10.0),
//                              child: new SizeCard(
//                                text: "L",
//                                color: (test2 ? indicatorColor : Colors.green),
//                                changstate: changeState2,
//                              ),
//                            ),
//                            new Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 0.0,
//                                  top: 3.0,
//                                  bottom: 5.0,
//                                  right: 10.0),
//                              child: new SizeCard(
//                                text: "X",
//                                color: (test3 ? indicatorColor : Colors.green),
//                                changstate: changeState3,
//                              ),
//                            ),
                          ],
                        ),
                      ),
                      new TabBar(
                        indicatorColor: indicatorColor1,
                        labelColor: Colors.black,
                        labelStyle: new TextStyle(
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(119, 119, 119, 1.0),
                            fontSize: 14.0),
                        unselectedLabelColor: Colors.black45,
                        unselectedLabelStyle: new TextStyle(
                            fontWeight: FontWeight.normal,
                            color: const Color.fromRGBO(119, 119, 119, 1.0),
                            fontSize: 14.0),
                        controller: controller1,
                        tabs: pages.map((String page) {
                          return new Tab(
                            child: new Container(
                              child: new Center(
                                  heightFactor: 2.0, child: new Text(page)),
                            ),
                          );
                        }).toList(),
                      ),
                      new Container(
                        height: screenSize.height / 5.0,
                        margin: const EdgeInsets.only(left: 6.0, top: 3.0),
                        child: new TabBarView(
                          children: <Widget>[
                            new ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                new Detail(
                                  text:
                                  'Harga Sewa Gedung',
                                ),
                                new Detail(
                                  text:
                                  'Jumat - Minggu dan Hari libur Nasional',
                                ),
                                new Detail(
                                  text:
                                  'Siang (10:00-14:00) Rp 67.500.000',
                                ),
                                new Detail(
                                  text:
                                      'Malam (19:00-23:00) Rp 70.000.000',
                                ),
                                new Detail(
                                  text:
                                  '',
                                ),
                                new Detail(
                                  text:
                                  'Harga Catering',
                                ),
                                new Detail(
                                  text:
                                  'Harga 1 Januari 2019 - 31 Desember 2019',
                                ),
                                new Detail(
                                  text:
                                  'Menu 1 - Rp 172.500.000',
                                ),
                                new Detail(
                                  text:
                                  'Menu 2 - Rp 200.500.000',
                                ),
                              ],
                            ),
                            new ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                new Detail(
                                  text:
                                  'Finest Organizer was found in August 2009, started from a wish to create an unforgettable event with a lasting beautiful impression ',
                                ),
                                new Detail(
                                  text:
                                  'Our team will be committed wholeheartedly to help you in fulfilling your dreams by creating the best events.',
                                ),
                              ],
                            ),
                          ],
                          controller: controller1,
                        ),
                      ),
//                      new Container(
//                        decoration: new BoxDecoration(
//                            color: Colors.white,
//                            border: new Border(
//                                bottom: new BorderSide(
//                              color: Colors.black26,
//                            ))),
//                        child: new Container(
//                            margin:
//                                const EdgeInsets.only(bottom: 5.0, left: 6.0),
//                            child: new Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                new Text(
//                                  "STYLE NOTE",
//                                  style: textDescriptionheader,
//                                )
//                              ],
//                            )),
//                      ),
//                      new Container(
//                        decoration: new BoxDecoration(
//                            color: Colors.white,
//                            border: new Border(
//                                bottom: new BorderSide(
//                              color: Colors.black26,
//                            ))),
//                        child: new Container(
//                            margin: const EdgeInsets.only(
//                                left: 6.0, top: 10.0, bottom: 5.0, right: 0.0),
//                            child: new Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                new Text(
//                                  "Fashion has taken today's youth by surprise, and the avaibility of numerous options just leaves them spoilt of choice. Online stores fuel fashion by making the latest trending dresses, accessories, and apparels available to you within a few clicks. Shopping is no longer a day long affair with online shopping",
//                                  style: textDescription,
//                                ),
//                                new Padding(
//                                  padding: const EdgeInsets.only(
//                                      left: 0.0,
//                                      top: 10.0,
//                                      bottom: 2.0,
//                                      right: 10.0),
//                                  child: new Row(
//                                    children: <Widget>[
//                                      new Text(
//                                        'MORE INFO',
//                                        style: textDescriptionheader,
//                                      )
//                                    ],
//                                  ),
//                                )
//                              ],
//                            )),
//                      ),
//                      new Container(
//                        decoration: new BoxDecoration(
//                            color: Colors.white,
//                            border: new Border(
//                                bottom: new BorderSide(
//                              color: Colors.black26,
//                            ))),
//                        child: new Container(
//                            margin: const EdgeInsets.only(
//                                left: 6.0, top: 10.0, bottom: 10.0, right: 0.0),
//                            child: new Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                new Text(
//                                  "PRODUCT CODE: 1760167",
//                                  style: textDescription,
//                                ),
//                                new Text(
//                                  'Sold By: Funfash',
//                                  style: textDescription,
//                                ),
//                                new Text(
//                                  'Tax info: Applicable GST will be charged at the time of checkout',
//                                  style: textDescription,
//                                )
//                              ],
//                            )),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: new Container(
        margin:
            const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 0.0, left: 0.0),
        height: screenSize.height / 12,
        decoration: new BoxDecoration(
          color: gotobagColor,
        ),
        child: new Row(
          children: <Widget>[
//            new Container(
//              height: screenSize.height / 12,
//              width: screenSize.width / 2.5,
//              decoration: new BoxDecoration(color: saveColor),
//              padding: const EdgeInsets.only(
//                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
//              child: new GestureDetector(
//                onTap: () {
//                  changeState4();
//                },
//                child: new Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    new Icon(
//                      Icons.list,
//                      color: Colors.white,
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(
//                          left: 2.0, right: 0.0, top: 0.0, bottom: 0.0),
//                      child: new Text(test4 ? "SAVE" : "SAVED",
//                          style: new TextStyle(
//                              fontSize: 15.0,
//                              letterSpacing: 0.8,
//                              fontWeight: FontWeight.w400,
//                              fontFamily: "Roboto",
//                              color: Colors.white)),
//                    ),
//                  ],
//                ),
//              ),
//            ),
            new Container(
              height: screenSize.height / 12,
              width: screenSize.width / 1.8,
              decoration: new BoxDecoration(color: gotobagColor),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20.0, top: 0.0, bottom: 0.0),
              child: new GestureDetector(
//                onTap: () {
//                  ((test && test1 && test2 && test3)
//                      ? _showAlert()
//                      : Navigator.of(context).pushNamed('/bag'));
//                },
                onTap: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new Bag(

                      ),
                    )),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    new Text("Booking",
                        style: new TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
