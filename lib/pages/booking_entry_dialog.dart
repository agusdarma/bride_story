import 'dart:async';
import 'dart:convert';

import 'package:bride_story/models/booking_model.dart';
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

  Widget _createAppBar(BuildContext context) {
    return new AppBar(
      title: widget.bookingDataToEdit == null
          ? const Text("New booking")
          : const Text("Edit booking"),
      actions: [
        new FlatButton(
          onPressed: () {
            _sendToEngine(
                context,
                new BookingData(
                    _time, _idVenue, _dateTime.millisecondsSinceEpoch));
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new Column(
        children: [
          new ListTile(
            leading: new Icon(Icons.today, color: Colors.grey[500]),
            title: new DateTimeItem(
              dateTime: _dateTime,
              onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            ),
          ),
          new RadioListTile<int>(
            title: const Text('Day'),
            value: 1,
            groupValue: _time,
            onChanged: (value) {
              setState(() {
                _time = value;
              });
            },
          ),
          new RadioListTile<int>(
            title: const Text('Night'),
            value: 2,
            groupValue: _time,
            onChanged: (value) {
              setState(() {
                _time = value;
              });
            },
          ),
        ],
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
