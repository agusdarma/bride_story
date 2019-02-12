import 'package:bride_story/plugins/components/ProductDetailCard.dart';
import 'package:bride_story/plugins/components/ProductSizeCard.dart';
import 'package:bride_story/plugins/components/SizeCard.dart';
import 'package:bride_story/theme/style.dart';
import 'package:flutter/material.dart';
import 'Details.dart';
import 'style.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final ExactAssetImage pic;

  ProductDetail({
    this.name,
    this.pic,
  });
  @override
  ProductDetailState createState() =>
      new ProductDetailState(name: name, pic: pic);
  static String tag = 'ProductDetail';
}

enum MyDialogAction { yes }

class ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  final String name;
  final ExactAssetImage pic;

  ProductDetailState({this.name, this.pic});

  List<String> images = ["pic", "pic"];
  List<String> pages = ["DETAILS", "MATERIAL & CARE"];
  bool test = true;
  bool test1 = true;
  bool test2 = true;
  bool test3 = true;
  bool test4 = true;

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
        "The Model with height 1.7m is wearing size S",
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

  @override
  Widget build(BuildContext context) {
    final TabController controller = new TabController(length: 2, vsync: this);
    final TabController controller1 = new TabController(length: 2, vsync: this);

    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: new Text(
          "PRODUCT DETAIL",
          style: textStylew600,
        ),
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/productList");
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
                          length: images.length,
                          child: new Container(
                            child: new Stack(
                              children: <Widget>[
                                new TabBarView(
                                  children: images.map((String image) {
                                    return new GestureDetector(
                                      child: new Container(
                                        height: 260.0,
                                        padding: new EdgeInsets.only(
                                            top: 20.0,
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 40.0),
                                        child: new Image(
                                          image: pic,
                                          height: screenSize.height / 2.3,
                                          width: screenSize.width / 1.4,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  controller: controller,
                                ),
                                new Container(
                                  alignment: new FractionalOffset(0.5, 0.95),
                                  child: new TabPageSelector(
                                    controller: controller,
                                    color: Colors.white,
                                    selectedColor: Colors.grey,
                                  ),
                                ),
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
                          '\$1,499',
                          style: textPrice,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                        child: new Text(
                          '\$2,499',
                          style: textDiscount,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 5.0, bottom: 5.0, right: 0.0),
                        child: new Text(
                          '40% Off',
                          style: textPriceActual,
                        ),
                      ),
                    ],
                  ),
                ),
                new ProductDetailCard(
                  icon: Icons.local_offer,
                  text: "Tap to get further info",
                  onPress: _showAlert1,
                ),
                new Container(
                  height: 500.0,
                  padding: const EdgeInsets.only(
                      left: 6.0, right: 10.0, top: 0.0, bottom: 0.0),
                  decoration: new BoxDecoration(image: backgroundImage),
                  child: new Column(
                    children: <Widget>[
                      new ProductSizeCard(
                        icon: Icons.straighten,
                        text: 'Size',
                        text1: "SIZE CHART",
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
                                text: "S",
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
                                text: "M",
                                color: (test1 ? indicatorColor : Colors.green),
                                changstate: changeState1,
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0,
                                  top: 3.0,
                                  bottom: 5.0,
                                  right: 10.0),
                              child: new SizeCard(
                                text: "L",
                                color: (test2 ? indicatorColor : Colors.green),
                                changstate: changeState2,
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0,
                                  top: 3.0,
                                  bottom: 5.0,
                                  right: 10.0),
                              child: new SizeCard(
                                text: "X",
                                color: (test3 ? indicatorColor : Colors.green),
                                changstate: changeState3,
                              ),
                            ),
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
                        height: screenSize.height / 9.0,
                        margin: const EdgeInsets.only(left: 6.0, top: 10.0),
                        child: new TabBarView(
                          children: <Widget>[
                            new Detail(
                              text:
                                  'Stay warm and trendy this winter with this trendy sweater from nouk.Layer it on a tee, or just team it with a pair of jeans and boots when you head out this winter',
                            ),
                            new Detail(
                              text:
                                  '76% acrylic, 19% polyster, 5% metallic yarn Hand-wash cold',
                            )
                          ],
                          controller: controller1,
                        ),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border(
                                bottom: new BorderSide(
                              color: Colors.black26,
                            ))),
                        child: new Container(
                            margin:
                                const EdgeInsets.only(bottom: 5.0, left: 6.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "STYLE NOTE",
                                  style: textDescriptionheader,
                                )
                              ],
                            )),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border(
                                bottom: new BorderSide(
                              color: Colors.black26,
                            ))),
                        child: new Container(
                            margin: const EdgeInsets.only(
                                left: 6.0, top: 10.0, bottom: 5.0, right: 0.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "Fashion has taken today's youth by surprise, and the avaibility of numerous options just leaves them spoilt of choice. Online stores fuel fashion by making the latest trending dresses, accessories, and apparels available to you within a few clicks. Shopping is no longer a day long affair with online shopping",
                                  style: textDescription,
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0,
                                      top: 10.0,
                                      bottom: 2.0,
                                      right: 10.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Text(
                                        'MORE INFO',
                                        style: textDescriptionheader,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border(
                                bottom: new BorderSide(
                              color: Colors.black26,
                            ))),
                        child: new Container(
                            margin: const EdgeInsets.only(
                                left: 6.0, top: 10.0, bottom: 10.0, right: 0.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "PRODUCT CODE: 1760167",
                                  style: textDescription,
                                ),
                                new Text(
                                  'Sold By: Funfash',
                                  style: textDescription,
                                ),
                                new Text(
                                  'Tax info: Applicable GST will be charged at the time of checkout',
                                  style: textDescription,
                                )
                              ],
                            )),
                      ),
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
            new Container(
              height: screenSize.height / 12,
              width: screenSize.width / 2.5,
              decoration: new BoxDecoration(color: saveColor),
              padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
              child: new GestureDetector(
                onTap: () {
                  changeState4();
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                          left: 2.0, right: 0.0, top: 0.0, bottom: 0.0),
                      child: new Text(test4 ? "SAVE" : "SAVED",
                          style: new TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              height: screenSize.height / 12,
              width: screenSize.width / 1.8,
              decoration: new BoxDecoration(color: gotobagColor),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20.0, top: 0.0, bottom: 0.0),
              child: new GestureDetector(
                onTap: () {
                  ((test && test1 && test2 && test3)
                      ? _showAlert()
                      : Navigator.of(context).pushNamed('/bag'));
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    new Text("GO TO BAG",
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
