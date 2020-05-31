import 'package:flutter/material.dart';
import 'package:stock_it/services/auth_service.dart';
import 'package:stock_it/widget/button_login.dart';
import 'package:stock_it/widget/tff_login.dart';

AuthService authService = new AuthService();

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  void login() {
    String email = emailCtrl.text.trim();
    String pass = passwordCtrl.text;

    authService.signinWithEmail(context, email, pass);

    debugPrint('$email, $pass');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TFFLogin(
            controller: emailCtrl,
            prefixIcon: Icons.email,
            labelText: 'Email',
            obsecureText: false,
          ),
          TFFLogin(
            controller: passwordCtrl,
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
