import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final text;

  const GroupCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18.0,
      ),
            ),
          ),
        ),
    );
  }
}
