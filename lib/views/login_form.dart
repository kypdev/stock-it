import 'package:flutter/material.dart';
import 'package:stock_it/widget/button_login.dart';
import 'package:stock_it/widget/tff_login.dart';

class LoginForm extends StatelessWidget {
  void login() {
    debugPrint('login');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TFFLogin(
            prefixIcon: Icons.email,
            labelText: 'Email',
            obsecureText: false,
          ),
          TFFLogin(
            prefixIcon: Icons.lock,
            labelText: 'Password',
            obsecureText: true,
          ),
          ButtonLogin(
            action: login,
            buttonText: 'Login',
          ),
        ],
      ),
    );
  }
}
