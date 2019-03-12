import 'package:flutter/material.dart';
import 'package:bride_story/theme/style.dart';

class HomeWithTab extends StatefulWidget {
  HomeWithTab({Key key}) : super(key: key);
  @override
  _HomeWithTabState createState() => new _HomeWithTabState();
}

class _HomeWithTabState extends State<HomeWithTab>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController controller = new TabController(length: 6, vsync: this);
    Size screenSize = MediaQuery.of(context).size;
    return new Container(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
      height: screenSize.height / 11.0,
      width: screenSize.width / 1.0,
      decoration: new BoxDecoration(),
      child: new TabBar(
        tabs: <Tab>[
          new Tab(
            child: new InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/homePro");
              },
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    new Icon(
                      Icons.home,
                      size: 25.0,
                      color: Colors.black45,
                    ),
                    new Text(
                      "Home",
                      style: new TextStyle(
                        fontSize: 8.5,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Tab(
            child: new InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/categories");
              },
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.category,
                    size: 25.0,
                    color: Colors.black45,
                  ),
                  new Text(
                    "Categories",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromRGBO(119, 119, 119, 1.0),
                        fontSize: 8.5),
                  )
                ],
              ),
            ),
          ),
          new Tab(
            child: new InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/notification");
              },
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.notifications_none,
                    size: 25.0,
                    color: Colors.black45,
                  ),
                  new Text(
                    "Notifications",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromRGBO(119, 119, 119, 1.0),
                        fontSize: 8.5),
                  )
                ],
              ),
            ),
          ),
          new Tab(
            child: new InkWell(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.card_travel,
                    size: 25.0,
                    color: indicatorColor,
                  ),
                  new Text(
                    "Bag",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: indicatorColor,
                        fontSize: 8.5),
                  ),
                ],
              ),
            ),
          ),
          new Tab(
            child: new InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/home");
              },
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.account_box,
                    size: 25.0,
                    color: Colors.black45,
                  ),
                  new Text(
                    "Profile",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                        fontSize: 8.5),
                  )
                ],
              ),
            ),
          ),
        ],
        controller: controller,
        labelStyle: new TextStyle(
          fontSize: 9.0,
          color: const Color.fromRGBO(119, 119, 119, 1.0),
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
      ),
    );
  }
}
