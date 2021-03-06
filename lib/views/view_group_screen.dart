import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stock_it/views/add_pro.dart';
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
                      return InkWell(
                        onLongPress: () {
                          var id = docs.documentID.toString();
                          print('$id');

                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Are you sure to delete this item?",
                            desc: "",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "YES",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Firestore.instance
                                      .collection('users')
                                      .document(uid)
                                      .collection('groups')
                                      .document(id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                              ),
                              DialogButton(
                                child: Text(
                                  "NO",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(116, 116, 191, 1.0),
                                  Color.fromRGBO(52, 138, 199, 1.0)
                                ]),
                              )
                            ],
                          ).show();
                        },
                        onTap: () {
                          var docid = docs.documentID.toString();

                          print('docid: $docid');

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPro(
                                        docsID: docid,
                                      )));
                        },
                        child: GroupCard(
                          title: docs['name'],
                          detail: docs['detail'],
                          img: docs['img'],
                          item: docs['item'],
                        ),
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
