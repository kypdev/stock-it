import 'package:flutter/material.dart';
import 'package:stock_it/widget/button_login.dart';
import 'package:stock_it/widget/singup.dart';
import 'package:stock_it/widget/text_new.dart';
import 'package:stock_it/widget/tff_login.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                FormSignup(),
                SigninText(),
                // NewNome(),
                // NewEmail(),
                // PasswordInput(),
                // ButtonNewUser(),
                // UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormSignup extends StatelessWidget {
  void signup() {
    debugPrint('signup');
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
          TFFLogin(
            prefixIcon: Icons.lock,
            labelText: 'confirm password',
            obsecureText: true,
          ),
          TFFLogin(
            prefixIcon: Icons.phone,
            labelText: 'tel',
            obsecureText: false,
          ),
          ButtonLogin(
            action: signup,
            buttonText: 'Signup',
          ),
        ],
      ),
    );
  }
}

class SigninText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Have we met before?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Signin',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
