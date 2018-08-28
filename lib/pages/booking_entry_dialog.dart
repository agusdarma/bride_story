import 'dart:async';
import 'dart:convert';

import 'package:bride_story/models/booking_model.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class BookingEntryDialog extends StatefulWidget {
  final int idVenue;
  final BookingData bookingDataToEdit;
  final int dateTimeMilisecond;

  BookingEntryDialog.add(this.idVenue, this.dateTimeMilisecond)
      : bookingDataToEdit = null;

  BookingEntryDialog.edit(this.bookingDataToEdit, this.dateTimeMilisecond)
      : idVenue = bookingDataToEdit.idVenue;

  @override
  BookingEntryDialogState createState() {
    if (bookingDataToEdit != null) {
      return new BookingEntryDialogState(bookingDataToEdit.dateTimeMilisecond,
          bookingDataToEdit.idVenue, bookingDataToEdit.time);
    } else {
      return new BookingEntryDialogState(dateTimeMilisecond, null, idVenue);
    }
  }
}

class BookingEntryDialogState extends State<BookingEntryDialog> {
  DateTime _dateTime;
  int dateTimeMilisecond;
  int _time;
  // 1 day, 2 night
  String _namaPernikahan;
  String _penanggungJawab1;
  String _handphone1;
  String _penanggungJawab2;
  String _handphone2;
  int _idVenue;
  // TextEditingController _textController;

  BookingEntryDialogState(this.dateTimeMilisecond, this._time, this._idVenue);

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  _sendToEngine(BuildContext context, BookingData bookingData) {
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(bookingData);
    print(parameterJson);
    http.createUpdateBooking(parameterJson).then((dynamic response) {
      setState(() {
        Navigator.of(context).pop(response);
      });
    });
  }

  void _showDialogError(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CustomAlertDialog(
          title: new Text("Warning",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
          content: new Text(message,
              style: TextStyle(
                fontSize: 18.0,
                // color: Colors.red,
                // fontWeight: FontWeight.bold,
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
                  style: TextStyle(
                    fontSize: 18.0,
                    // color: Colors.red,
                    // fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _createAppBar(BuildContext context) {
    return new AppBar(
      title: widget.bookingDataToEdit == null
          ? const Text("New booking")
          : const Text("Edit booking"),
      actions: [
        new FlatButton(
          onPressed: () {
            if (_time == null) {
              _showDialogError('Silahkan pilih waktu event.');
              return;
            }
            if (_namaPernikahan == null) {
              _showDialogError('Silahkan isi nama pernikahan.');
              return;
            }
            if (_penanggungJawab1 == null) {
              _showDialogError('Silahkan isi nama penanggung jawab 1.');
              return;
            }
            if (_handphone1 == null) {
              _showDialogError('Silahkan isi handphone 1.');
              return;
            }
            if (_penanggungJawab2 == null) {
              _showDialogError('Silahkan isi penanggung jawab 2.');
              return;
            }
            if (_handphone2 == null) {
              _showDialogError('Silahkan isi handphone 2.');
            } else {
              _sendToEngine(
                  context,
                  new BookingData(
                      _time,
                      _idVenue,
                      _dateTime.millisecondsSinceEpoch,
                      _namaPernikahan,
                      _penanggungJawab1,
                      _handphone1,
                      _penanggungJawab2,
                      _handphone2));
            }
          },
          child: new Text('SAVE',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeMilisecond);
    // _textController = new TextEditingController(text: _note);
  }

  Widget namaPernikahan(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text('Pernikahan:  ',
              //     style: TextStyle(
              //       fontSize: 15.0,
              //       fontWeight: FontWeight.bold,
              //     )),
              // TextField(
              //   decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: 'Please enter a search term'),
              // ),
              new Flexible(
                child: new TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    setState(() {
                      _namaPernikahan = text;
                    });
                  },
                  decoration:
                      const InputDecoration(helperText: "Nama Pernikahan : "),
                  // style: Theme.of(context).textTheme.body1,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget penanggungJawab1(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    setState(() {
                      _penanggungJawab1 = text;
                    });
                  },
                  decoration: const InputDecoration(
                      helperText: "Penanggung Jawab 1 : "),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget handPhone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      _handphone1 = text;
                    });
                  },
                  decoration: const InputDecoration(helperText: "Handphone : "),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget penanggungJawab2(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    setState(() {
                      _penanggungJawab2 = text;
                    });
                  },
                  decoration: const InputDecoration(
                      helperText: "Penanggung Jawab 2 : "),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget handPhone2(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      _handphone2 = text;
                    });
                  },
                  decoration:
                      const InputDecoration(helperText: "Handphone 2 : "),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget tglBooking(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Tanggal:  ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
              new DateTimeItem(
                dateTime: _dateTime,
                onChanged: (dateTime) => setState(() => _dateTime = dateTime),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget dayEvent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text('Day Event'),
              new Radio(
                value: 1,
                groupValue: _time,
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget nightEvent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text('Night Event'),
              new Radio(
                value: 2,
                groupValue: _time,
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget namaVenue(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Lokasi Venue:  ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Balai Samudera',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
      )),
    );
  }

  Widget desc1(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                    'Pembayaran dapat dilakukan dengan mentransfer ke rekening :',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget desc2(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Bank :',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text('Bank Mandiri',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget desc3(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('No Rekening :',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text('066-XXXXXXXXX',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget desc4(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Atas Nama :',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text('Balai Samudra',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget desc5(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Booking Charge :',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text('Rp. 1000.000',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget hargaVenue(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 9.0, right: 9.0),
      // margin: EdgeInsets.only(top: 5.0, bottom: 6.0),
      child: Material(
          // elevation: 4.0,
          // borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Harga Venue:  ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Rp. 30.000.000',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
      )),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _time = value;

      switch (_time) {
        case 0:
          // _result = _currencyCalculate(_currencyController.text, EURO_MUL);
          // if (_result > -1.0) {
          //   _textResult = '${_currencyController.text} USD = ${_result.toStringAsFixed(3)} Euro';
          // } else {
          //   _textResult = 'Cannot convert USD to Euro\nPlease check the Amount!';
          // }
          break;
        case 1:
          // _result = _currencyCalculate(_currencyController.text, POUND_MUL);
          // if (_result > -1.0) {
          //   _textResult = '${_currencyController.text} USD = ${_result.toStringAsFixed(3)} Pound';
          // } else {
          //   _textResult = 'Cannot convert USD to Pound\nPlease check the Amount!';
          // }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new SingleChildScrollView(
        child: new Column(
          children: [
            // tglBooking(context),
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     children: <Widget>[
            //       new ListTile(
            //           leading: const Icon(Icons.place),
            //           title: new Text('Balai Samudra')),
            namaVenue(context),
            new Divider(
              color: Colors.black,
              height: 2.0,
            ),
            hargaVenue(context),
            new Divider(
              color: Colors.black,
              height: 2.0,
            ),
            // new ListTile(
            //   leading: new Icon(Icons.today, color: Colors.blue),
            //   title: new DateTimeItem(
            //     dateTime: _dateTime,
            //     onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            //   ),
            // ),
            // tglBooking(context),
            // Text('Tanggal:  ',
            //     style: TextStyle(
            //       fontSize: 15.0,
            //       fontWeight: FontWeight.bold,
            //     )),
            Padding(
              child: new DateTimeItem(
                dateTime: _dateTime,
                onChanged: (dateTime) => setState(() => _dateTime = dateTime),
              ),
              padding: EdgeInsets.all(6.0),
            ),
            new Divider(
              color: Colors.black,
              height: 2.0,
            ),

            // new RadioListTile<int>(
            //   title: const Text('Day Event'),
            //   value: 1,
            //   groupValue: _time,
            //   onChanged: (value) {
            //     setState(() {
            //       _time = value;
            //     });
            //   },
            // ),
            // new RadioListTile<int>(
            //   title: const Text('Night Event'),
            //   value: 2,
            //   groupValue: _time,
            //   onChanged: (value) {
            //     setState(() {
            //       _time = value;
            //     });
            //   },
            // ),
            // new Text('Day Event'),
            // new Radio(
            //   value: 1,
            //   groupValue: _time,
            //   onChanged: _handleRadioValueChange,
            // ),
            // dayEvent(context),
            // new Text('Night Event'),
            // new Radio(
            //   value: 2,
            //   groupValue: _time,
            //   onChanged: _handleRadioValueChange,
            // ),
            dayEvent(context),
            nightEvent(context),
            namaPernikahan(context),
            penanggungJawab1(context),
            handPhone(context),
            penanggungJawab2(context),
            handPhone2(context),
            new Divider(
              color: Colors.black,
              height: 2.0,
            ),
            desc1(context),
            desc2(context),
            desc3(context),
            desc4(context),
            desc5(context),
            new Divider(
              color: Colors.black,
              height: 10.0,
            ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat('EEEE, MMMM d').format(date))),
          ),
        ),
        // new InkWell(
        //   onTap: (() => _showTimePicker(context)),
        //   child: new Padding(
        //       padding: new EdgeInsets.symmetric(vertical: 8.0),
        //       child: new Text('$time')),
        // ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        // firstDate: date.subtract(const Duration(days: 20000)),
        // lastDate: new DateTime.now());
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day, time.hour, time.minute));
    }
  }
}
