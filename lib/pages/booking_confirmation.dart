import 'dart:convert';

import 'package:async/async.dart';
import 'package:bride_story/models/result_mybooking.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class BookingConfirmation extends StatefulWidget {
  final ResultMyBookingModel bookingData;

  const BookingConfirmation({Key key, this.bookingData}) : super(key: key);
  @override
  _BookingConfirmationState createState() =>
      _BookingConfirmationState(this.bookingData);
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  _BookingConfirmationState(this.bookingData);
  File image;
  ResultMyBookingModel bookingData;
  @override
  Widget build(BuildContext context) {
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

    //  To use Gallery or File Manager to pick Image
//  Comment Line No. 19 and uncomment Line number 20
    picker() async {
      print('Picker is called');
      // File img = await ImagePicker.pickImage(source: ImageSource.camera);
      File img = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        image = img;
        setState(() {});
      }
    }

    Widget tglBooking(int bookingDate) {
      int year = new DateTime.fromMillisecondsSinceEpoch(bookingDate).year;
      int month = new DateTime.fromMillisecondsSinceEpoch(bookingDate).month;
      int day = new DateTime.fromMillisecondsSinceEpoch(bookingDate).day;
      String displayedDate =
          day.toString() + ' ' + _convertBulan(month) + ' ' + year.toString();
      return Text(displayedDate);
    }

    Widget card(BuildContext context) {
      return new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Divider(
              color: Colors.blue,
              indent: 1.0,
            ),
            GestureDetector(
              child: new ListTile(
                leading: new Icon(
                  Icons.add_location,
                  color: Colors.blue,
                  size: 26.0,
                ),
                title: new Text(
                  bookingData.titleVenue,
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: tglBooking(bookingData.dateTime),
              ),
            ),

            // new Divider(
            //   color: Colors.blue,
            //   indent: 16.0,
            // ),
            new ListTile(
              leading: new Icon(
                Icons.people,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                bookingData.namaPernikahan,
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            new ListTile(
              leading: new Icon(
                Icons.phone,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                bookingData.handPhone1,
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            new ListTile(
              leading: new Icon(
                Icons.attach_money,
                color: Colors.blue,
                size: 26.0,
              ),
              title: new Text(
                "Rp. 1000.000",
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Upload Bukti Pembayaran :'),
                ),
                GestureDetector(
                  child: new Icon(
                    Icons.file_upload,
                    color: Colors.blue,
                    size: 26.0,
                  ),
                  onTap: picker,
                ),

                // new FloatingActionButton(
                //   onPressed: picker,
                //   child: new Icon(
                //     Icons.camera_alt,
                //     color: Colors.blue,
                //     size: 26.0,
                //   ),
                // ),
              ],
            ),
            new Divider(
              height: 5.0,
            ),
            image == null
                ? new Text('No Image to Show ')
                : new Image.file(
                    image,
                    width: 200.0,
                    height: 150.0,
                  ),
          ],
        ),
      );
    }

    Widget sizedBox(BuildContext context) {
      return new Container(
          margin: new EdgeInsets.only(left: 6.0, right: 6.0),
          child: new SizedBox(
            // height: 220.0,
            child: card(context),
          ));
    }

    Widget center(BuildContext context) {
      return new Padding(
        padding: EdgeInsets.all(1.0),
        child: sizedBox(context),
      );
    }

    upload(File imageFile) async {
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse("http://192.168.0.101:6556/bride-trx/uploadImages");

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }

    _uploadToEngine(BuildContext context, ResultMyBookingModel bookingData) {
      // HttpServices http = new HttpServices();
      // const JsonEncoder encoder = const JsonEncoder();
      // String parameterJson = encoder.convert(bookingData);
      // print(parameterJson);
      // http.createUpdateBooking(parameterJson).then((dynamic response) {
      //   setState(() {
      //     Navigator.of(context).pop(response);
      //   });
      // });
      upload(image);
    }

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Confirmation Booking"),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                _uploadToEngine(context, bookingData);
              },
              child: new Text('Confirm',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            new Expanded(
              child: new Container(child: center(context)),
            ),
          ],
        ),
      ),
    );
  }
}
