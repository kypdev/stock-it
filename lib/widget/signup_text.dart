import 'package:flutter/material.dart';

class SignupText extends StatelessWidget {
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
              'Your first time?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Sing up',
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
