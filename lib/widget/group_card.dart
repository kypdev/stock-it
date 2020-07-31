import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final title;
  final img;
  final detail;
  final item;

  const GroupCard({Key key, this.title, this.img, this.detail, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        elevation: 10.0,
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                    image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                  ),
                ),
              ),
              Text(
                'Title: ' + title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                'Detail: ' + title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                'Quantity: ' + item,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
