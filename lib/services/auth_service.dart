import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  signupWithEmail(
    BuildContext context,
    fname,
    lname,
    email,
    pass,
    tel,
  ) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) =>
            _firestore.collection('users').document(user.user.uid).setData({
              'firstname': fname,
              'lastname': lname,
              'email': email,
              'tel': tel,
              'firstname': fname,
              'firstname': fname
            }))
        .then((_) {
      debugPrint('signupOK');
      Navigator.pushReplacementNamed(context, '/home');
    }).catchError((e) {
      debugPrint('signupErr: $e');
    });
  }

  signout(context) async {
    _auth.signOut().then((result) {
      Navigator.pushReplacementNamed(context, '/login');
    }).catchError((e) => debugPrint('signout: $e'));
  }
}
