import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:stock_it/services/auth_service.dart';
import 'package:stock_it/widget/button_login.dart';
import 'package:stock_it/widget/custom_alert_dialog.dart';
import 'package:stock_it/widget/singup.dart';
import 'package:stock_it/widget/text_new.dart';
import 'package:stock_it/widget/tff_login.dart';

AuthService authService = new AuthService();
CustomAlertDialog customAlertDialog = new CustomAlertDialog();

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

class FormSignup extends StatefulWidget {
  @override
  _FormSignupState createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  TextEditingController firstnameCtrl = new TextEditingController();

  TextEditingController lastnameCtrl = new TextEditingController();

  TextEditingController emailCtrl = new TextEditingController();

  TextEditingController passwordCtrl = new TextEditingController();

  TextEditingController conpasswordCtrl = new TextEditingController();

  TextEditingController telCtrl = new TextEditingController();

  void signup() {
    String fname = firstnameCtrl.text.trim();
    String lname = lastnameCtrl.text.trim();
    String email = emailCtrl.text.trim();
    String pass = passwordCtrl.text;
    String conpass = conpasswordCtrl.text;
    String tel = telCtrl.text.trim();

    if (pass != conpass) {
      debugPrint('password not match!!');
      customAlertDialog.warningAlertDialog(
          context: context,
          dialogType: DialogType.WARNING,
          desc: 'Password not match!!',
          );
    } else {
      debugPrint('$fname, $lname, $email, $pass, $conpass, $tel');
      authService.signupWithEmail(context, fname, lname, email, pass, tel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TFFLogin(
            controller: firstnameCtrl,
            prefixIcon: Icons.person,
            labelText: 'Firstname',
            obsecureText: false,
          ),
          TFFLogin(
            controller: lastnameCtrl,
            prefixIcon: Icons.person,
            labelText: 'Lastname',
            obsecureText: false,
          ),
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
          TFFLogin(
            controller: conpasswordCtrl,
            prefixIcon: Icons.lock,
            labelText: 'confirm password',
            obsecureText: true,
          ),
          TFFLogin(
            controller: telCtrl,
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
