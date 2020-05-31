import 'package:flutter/material.dart';
import 'package:stock_it/services/auth_service.dart';
import 'package:stock_it/widget/r_button.dart';

AuthService authService = new AuthService();

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              RButton(
                action: authService.signout(context),
                color: Colors.red,
                text: 'Signout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
