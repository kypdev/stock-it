import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class GroupService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;

  addGroup(groupName) async {
    user = await _auth.currentUser();
    var uid = user.uid;

    firestore
        .collection('users')
        .document(uid)
        .collection('groups')
        .add({'name': groupName})
        .then((value) => debugPrint('$value'))
        .catchError((e) => debugPrint('Err: $e'));

    debugPrint('p: $uid');
  }

  getGroupName() async {
    user = await _auth.currentUser();
    var uid = user.uid;
    firestore
        .collection('users')
        .document(uid)
        .collection('groups')
        .snapshots();
    // return groupName;
  }
}
