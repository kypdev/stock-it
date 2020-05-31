import 'package:flutter/material.dart';

class RButton extends StatelessWidget {
  final action;
  final text;
  final color;

  const RButton({Key key, this.action, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: action,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text('$text'),
      ),
    );
  }
}
