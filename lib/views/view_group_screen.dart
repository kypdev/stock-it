import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_it/widget/group_card.dart';

class ViewGroupScreen extends StatefulWidget {
  @override
  _ViewGroupScreenState createState() => _ViewGroupScreenState();
}

class _ViewGroupScreenState extends State<ViewGroupScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseUser user;

  Firestore firestore = Firestore.instance;

  String uid;

  userId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uuid = user.uid.toString();
    print(uuid);
    setState(() {
      uid = uuid;
    });
  }

  @override
  void initState() {
    super.initState();
    userId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('View Group'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                print('value: $uid');
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(uid)
              .collection('groups')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('load');
                case ConnectionState.active:
                  return ListView(
                    children:
                        snapshot.data.documents.map((DocumentSnapshot docs) {
                      return GroupCard(
                        title: docs['name'],
                        detail: docs['detail'],
                        img: docs['img'],
                        item: docs['item'],
                      );
                    }).toList(),
                  );
                case ConnectionState.done:
                  return Text('done');
                case ConnectionState.none:
                  return Text('none');
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: snapshot.data.documents.map((DocumentSnapshot docs) {
                  return GroupCard(
                    title: docs['name'],
                    detail: docs['detail'],
                    img: docs['img'],
                    item: docs['item'],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
