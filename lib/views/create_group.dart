import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Text('create group'),
      ],
    ));
  }
}
