import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stock_it/services/group_service.dart';
import 'package:stock_it/widget/group_card.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupCtrl = new TextEditingController();
  GroupService groupService = new GroupService();

  FirebaseUser user;

  addGroup() async {
    String groupName = groupCtrl.text;
    debugPrint(groupName);
    groupService.addGroup(groupName);
    groupCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document('wz0ko04QtoMw1FrobTNQJg61fve2')
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
                  Alert(
                    context: context,
                    title: 'Add Group',
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: groupCtrl,
                          decoration: InputDecoration(
                            icon: Icon(Icons.shop_two),
                            labelText: '+NameGroup',
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: addGroup,
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ],
                  ).show();
                }),
          ],
        ),
      ),
    );
  }
}
