import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget rButton({
  context,
  action,
  text,
  color,
}) {
  return RaisedButton(
    onPressed: action,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    child: Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        '$text',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
