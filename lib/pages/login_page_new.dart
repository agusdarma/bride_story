import 'dart:convert';

import 'package:bride_story/data/login_data_vo.dart';
import 'package:bride_story/pages/custom_alert_dialog.dart';
import 'package:bride_story/pages/signup_page.dart';
import 'package:bride_story/services/http_services.dart';
import 'package:bride_story/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validate/validate.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// class _LoginData {
//   String email = '';
//   String password = '';
//   String sessionData = '';
//   String sessionDate = '';

// }

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LoginDataVo _data = new LoginDataVo("", "", "", 0,1);

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

  _loginToEngine(BuildContext context, LoginDataVo _data) {
    HttpServices http = new HttpServices();
    const JsonEncoder encoder = const JsonEncoder();
    String parameterJson = encoder.convert(_data);
    http.loginProcess(parameterJson).then((dynamic response) {
      setState(() {
        int rc = response['rc'];
        if (0 == rc) {
          saveLoginDataInSharedPreferences(
              response['otherMessage'], keyLoginParam);
          print('abis login');
          const JsonDecoder decoder = const JsonDecoder();
          Map loginDataVo = decoder.convert(response['otherMessage']);
          Navigator.of(context).pop(loginDataVo);
        } else {
          _showDialogError(response['messageRc']);
        }
        // const JsonDecoder decoder = const JsonDecoder();
        // Map loginDataVo = decoder.convert(response['otherMessage']);
        // print(response['otherMessage']);
        // print(loginDataVo['sessionData']);

        // print(response['messageRc']);
        // print(response['rc']);
      });
    });
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      // print('Printing the login data.');
      // print('Email: ${_data.email}');
      // print('Password: ${_data.password}');
      _loginToEngine(context, _data);
    }
  }

  void signUp() {
    _navigateSignUpPage(context);
  }

  void forgetPassword() {
    // _navigateSignUpPage(context);
  }

  _navigateSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Login',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
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
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
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
                      'Login',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                new FlatButton(
                  child: Text("Don't have an account? Sign Up",
                      style: TextStyle(
                        fontSize: 14.0,
                      )),
                  onPressed: signUp,
                ),
                new FlatButton(
                  child: Text("Forgot password? Reset Password",
                      style: TextStyle(
                        fontSize: 14.0,
                      )),
                  onPressed: forgetPassword,
                )
              ],
            ),
          )),
    );
  }
}
