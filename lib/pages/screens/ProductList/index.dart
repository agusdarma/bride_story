import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/plugins/components/ProductDetails.dart';
import 'package:bride_story/plugins/components/Sort.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:flutter/material.dart';
import '../../../theme/style.dart';
import 'style.dart';
import 'package:flutter/foundation.dart';

class ProductList extends StatefulWidget {
  final List<PageNew> allPages;
  final FilterParam parameter;

  ProductList({Key key,this.allPages,
    this.parameter}) : super(key: key);
  @override
  ProductListState createState() => new ProductListState(allPages, parameter);
  static String tag = 'ProductList';
}

class ProductListState extends State<ProductList>
    with TickerProviderStateMixin {
  ProductListState(this.allPages, this.parameter);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<PageNew> allPages;
  FilterParam parameter;

  @override
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new SortData();
        });
  }

  @override
  Widget build(BuildContext context) {
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
//          new Icon(
//            Icons.search,
//            color: Colors.black,
//            size: 25.0,
//          ),
        ],
        leading: new IconButton(
            icon: new Icon(
              Icons.chevron_left,
              size: 40.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/product");
            }),
      ),
      body: new ListView(
        padding:
            const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 5.0, right: 0.0),
        children: <Widget>[
          new Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(
                                Icons.date_range,
                                color: Colors.blue,
                              ),
                              onPressed: _showModalSheet),
//                          Icon(Icons.date_range,color: Colors.blue,),
                          new Text(
                            '28 Agustus 2018',
                            style: textStylesubTitleLightBAg,
                          ),
                        ],
                      ),
//                      new Text(
//                        '|',
//                        style:
//                            new TextStyle(fontSize: 28.0, color: Colors.grey),
//                      ),
//                      new Row(
//                        children: <Widget>[
//                          new IconButton(
//                            icon: new Icon(
//                              Icons.arrow_drop_down,
//                              color: Colors.grey,
//                            ),
//                            // onPressed: _showModalSheet
//                          ),
//                          new Text(
//                            'REFINE',
//                            style: textStylesubTitleLightBAg,
//                          ),
//                        ],
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Balai Samudra",
                  picture: model1,
                )
              ]),
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Van Heusen",
                  picture: model2,
                )
              ]),
            ],
          ),
          new Row(
            children: <Widget>[
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Hotel Hilton",
                  picture: model3,
                )
              ]),
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Raymonds",
                  picture: model4,
                )
              ]),
            ],
          ),
          new Row(
            children: <Widget>[
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Louis Vuitton",
                  picture: model5,
                )
              ]),
              new Column(children: <Widget>[
                new ProductDetails(
                  name: "Michael Kors",
                  picture: model6,
                )
              ]),
            ],
          ),
        ],
      ),
//      bottomNavigationBar: new HomeWithTab(),
    );
  }
}
