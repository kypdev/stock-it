import 'package:flutter/material.dart';

class TFFLogin extends StatelessWidget {
  final labelText;
  final prefixIcon;
  final sufficIcon;
  final obsecureText;
  final controller;

  const TFFLogin(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.sufficIcon,
      this.obsecureText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: controller,
          obscureText: obsecureText,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white,
            ),
            suffixIcon: sufficIcon,
            prefixStyle: TextStyle(
              color: Colors.white,
            ),
            fillColor: Colors.white.withOpacity(0.25),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
