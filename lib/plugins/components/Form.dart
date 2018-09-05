import 'package:flutter/material.dart';
import './InputFields.dart';
import 'package:validate/validate.dart';

class FormContainer extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  // Add validate email function.
  String _validateEmail(String value) {
    if (!Validate.isEmail(value)) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  // Add validate password function.
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              key: this._formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new TextFormField(
                      keyboardType: TextInputType
                          .emailAddress, // Use email input type for emails.
                      decoration: new InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address'),
                      validator: this._validateEmail,
                      onSaved: (String value) {
                        this._data.email = value;
                      }),
                  new TextFormField(
                      obscureText: true, // Use secure text for passwords.
                      decoration: new InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password'),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                        this._data.password = value;
                      }),
                  // new InputFieldArea(
                  //   hint: "Email",
                  //   obscure: false,
                  //   icon: Icons.person_outline,
                  // ),
                  // new InputFieldArea(
                  //   hint: "Password",
                  //   obscure: true,
                  //   icon: Icons.lock_outline,
                  // ),
                ],
              )),
        ],
      ),
    ));
  }
}

class _LoginData {
  String email = '';
  String password = '';
}
