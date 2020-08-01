import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stock_it/views/add_item_pro.dart';

import '../widget/group_card.dart';

class AddPro extends StatefulWidget {
  final docsID;

  const AddPro({Key key, this.docsID}) : super(key: key);
  @override
  _AddProState createState() => _AddProState();
}

class _AddProState extends State<AddPro> {
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
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(uid)
              .collection('groups')
              .document(widget.docsID)
              .collection('proitem')
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
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                                onPressed: () {
                                  Firestore.instance
                                      .collection('users')
                                      .document(uid)
                                      .collection('groups')
                                      .document(widget.docsID)
                                      .collection('proitem')
                                      .document(id)
                                      .delete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
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
                        child: GroupCard(
                          title: docs['name'],
                          detail: docs['detail'],
                          img: docs['img'],
                          item: docs['price'],
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 20.0),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          // onOpen: ()=>print('open dial'),
          // onClose: ()=>print('dial close'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.pinkAccent,
                label: 'Add Group',
                labelStyle: TextStyle(
                  fontSize: 18.0,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddItemPro(
                            docsID: widget.docsID,
                          )));
                  // Alert(
                  //   context: context,
                  //   title: 'Add Group',
                  //   content: Form(
                  //     key: _formKey,
                  //     child: Column(
                  //       children: <Widget>[
                  //         showImage(),
                  //         RaisedButton(
                  //           onPressed: () => chooseImage(context),
                  //           child: Text('Choose Image'),
                  //         ),
                  //         TextFormField(
                  //           controller: nameCtrl,
                  //           decoration: InputDecoration(
                  //             icon: Icon(Icons.shop_two),
                  //             labelText: 'Name',
                  //           ),
                  //         ),
                  //         TextFormField(
                  //           controller: nameCtrl,
                  //           decoration: InputDecoration(
                  //             icon: Icon(Icons.shop_two),
                  //             labelText: 'Detail',
                  //           ),
                  //         ),
                  //         TextFormField(
                  //           controller: nameCtrl,
                  //           decoration: InputDecoration(
                  //             icon: Icon(Icons.shop_two),
                  //             labelText: 'Price',
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   buttons: [
                  //     DialogButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'OK',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20.0,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ).show();
                }),
          ],
        ),
      ),
    );
  }
}
