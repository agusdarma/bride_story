import 'package:bride_story/pages/screens/ProductDetail/index.dart';
import 'package:bride_story/plugins/components/ProductListCard.dart';
import 'package:flutter/material.dart';


class ProductDetails extends StatelessWidget {
  final String name;
  final ExactAssetImage picture;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Container(
        height: screenSize.height / 1.9,
        width: screenSize.width / 2.0,
        padding: new EdgeInsets.all(2.0),
        child: new Card(
            child: new Padding(
                padding: const EdgeInsets.only(
                    left: 3.0, top: 5.0, bottom: 4.0, right: 0.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Hero(
                      tag: name,
                      child: new Material(
                        child: new InkWell(
                          onTap: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new ProductDetail(
                                          name: name,
//                                          pic: picture,
                                        ),
                                  )),
                          child: new Container(
                            height: screenSize.height / 2.8,
                            width: screenSize.width / 2.2,
                            child: new Image(
                              image: picture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    new ProductListCard(
                      name: name,
                      text1: "\$699 ",
                      text2: "\$12,99 ",
                      text3: "\$500 Off ",
                      text4: 'Super Slim Fit Formal Suit ',
                      icon: Icons.bookmark_border,
                    ),
                  ],
                ))));
  }

  ProductDetails({this.name, this.picture});
}
