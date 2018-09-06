import 'dart:convert';

import 'package:bride_story/data/signUp_data_vo.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/pages/login_page_new.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  SignUpDataVo _data = new SignUpDataVo("", "");

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void saveLoginDataInSharedPreferences(String loginData, String key) async {
    // print("saveLoginDataInSharedPreferences");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, loginData);
  }

  void _showDialogSuccess(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CustomAlertDialog(
          title: new Text("Info",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              )),
          content: new Text(message,
              style: TextStyle(
                fontSize: 18.0,
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
                  style: TextStyle(
                    fontSize: 18.0,
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

  _signUpToEngine(BuildContext context, SignUpDataVo _data) {
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(_data);
    http.signUpProcess(parameterJson).then((dynamic response) {
      setState(() {
        int rc = response['rc'];
        if (0 == rc) {
          // saveLoginDataInSharedPreferences(
          //     response['otherMessage'], keyLoginParam);
          // Navigator.of(context).pop();
          _showDialogSuccess(response['otherMessage']);
        } else {
          _showDialogError(response['messageRc']);
        }
      });
    });
  }

  _navigateLoginPage(BuildContext context) {
    Navigator.push(
      context,
      // new MaterialPageRoute(builder: (context) => new LoginScreen()),
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }

  void login() {
    _navigateLoginPage(context);
  }

  void signUp() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      // print('Printing the login data.');
      // print('Email: ${_data.email}');
      // print('Password: ${_data.password}');
      _signUpToEngine(context, _data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sign Up'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType
                        .emailAddress, // Use email input type for emails.
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address'),
                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.setEmail = value;
                    }),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password', labelText: 'Enter your password'),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.setPassword = value;
                    }),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Sign Up',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: this.signUp,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new FlatButton(
                  child: Text(
                    "Have an account? Login",
                  ),
                  onPressed: login,
                ),
              ],
            ),
          )),
    );
  }
}
