import 'package:bride_story/data/filter_param.dart';
import 'package:bride_story/models/venue_model.dart';
import 'package:bride_story/pages/screens/ProductDetail/index.dart';
import 'package:bride_story/pages/vendor_page_new.dart';
import 'package:bride_story/plugins/components/ProductListCard.dart';
import 'package:bride_story/plugins/library_map/page_new.dart';
import 'package:flutter/material.dart';


class BuildingDetails extends StatelessWidget {
  final List<PageNew> allPages;
  final FilterParam parameter;
  final String name;
  final String capacityVisitor;
  final String capacityParkir;
  final String hargaVenue;
  final String picture;
  final VenueModel venueModel;

  @override
  Widget build(BuildContext context) {
    _navigateVendorPage(BuildContext context, VenueModel venueModel) {
      parameter.idVenue = venueModel.id;
      // Navigator.pushNamed(context, "/vendorPage");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VendorPageNew(
              // mapController: mapController,
              // overlayController: overlayController,
              allPages: allPages,
              venueModel: venueModel,
              parameter: parameter,
            )),
      );
    }

    Size screenSize = MediaQuery.of(context).size;

    _navigateBuildingDetailPage(BuildContext context, VenueModel venueModel) {
      parameter.idVenue = venueModel.id;
      // Navigator.pushNamed(context, "/vendorPage");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new VendorPageNew(
              // mapController: mapController,
              // overlayController: overlayController,
              allPages: allPages,
              venueModel: venueModel,
              parameter: parameter,
            )),
      );
    }

    return new Container(
      color: Colors.white,

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
//                          onTap: () {
//                            _navigateVendorPage(context, venueModel);
//                          },
//                          onTap: () {
//                            _navigateBuildingDetailPage(context, venueModel);
//                          },
                          onTap: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new ProductDetail(
                                          name: name,
                                          pic: picture,
                                          allPages: allPages,
                                          parameter: parameter,
                                          venueModel: venueModel,
                                        ),
                                  )),
                          child: new Container(
                            height: screenSize.height / 2.8,
                            width: screenSize.width / 2.2,
                            child: new Image(
                              image: new NetworkImage(picture),
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
                      capacityVisitor: capacityVisitor,
                      capacityParkir: capacityParkir,
                      hargaVenue: hargaVenue,
                    ),
                  ],
                )))
    );
  }

  BuildingDetails({this.name, this.picture,this.capacityVisitor,this.capacityParkir,this.hargaVenue,this.allPages,this.parameter,this.venueModel});
}
