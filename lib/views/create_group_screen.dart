import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController createGroupCtrl = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;

  createGroup() async {
    if (_formKey.currentState.validate()) {
      // print('create group');

      // print('value: ${createGroupCtrl.text}');
      user = await auth.currentUser();
      var uid = user.uid;
      String groupName = createGroupCtrl.text;

      firestore
          .collection('users')
          .document(uid)
          .collection('groups')
          .add({'name': groupName})
          .then((value) => debugPrint('$value'))
          .catchError((e) => debugPrint('Err: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Group'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: createGroupCtrl,
                  validator: (value) {
                    if (value.isEmpty) return 'Group Name is empty!!';
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.shop_two),
                    labelText: '+NameGroup',
                  ),
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                  onPressed: () {
                    createGroup();
                  },
                  child: Text('Create Group'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
