import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Create Group'),
          centerTitle: true,
        ),
        body: Container(),
      ),
    );
  }
}