import 'package:flutter/material.dart';
import 'package:stock_it/widget/signup_text.dart';
import 'package:stock_it/widget/text_login.dart';
import 'package:stock_it/widget/vertical_text.dart';

import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    VerticalText(),
                    TextLogin(),
                  ]),
                  LoginForm(),
                  SignupText(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
