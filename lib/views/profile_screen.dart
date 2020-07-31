import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_it/services/auth_service.dart';
import 'package:stock_it/widget/r_button.dart';

AuthService authService = new AuthService();


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userID;
  signOut(context) {
    FirebaseAuth.instance
        .signOut()
        .then((_) => Navigator.pushReplacementNamed(context, '/login'));
  }

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userID)
              .snapshots(),
          builder: (context, sn) {
            if (!sn.hasData) {
              return Text('Loading data Please wait...');
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundColor: Colors.blue,
                    //   radius: 75.0,
                    //   child: CircleAvatar(
                    //     radius: 70.0,
                    //     backgroundColor: Color(0XFFFFFFFF),
                    //     backgroundImage: NetworkImage(sn.data['imgpro']),
                    //   ),
                    // ),
                    SizedBox(height: 20.0),

                    _form(
                      title: 'ชื่อ',
                      content: sn.data['firstname']
                    ),

                    _form(
                      title: 'นามสกุล',
                      content: sn.data['lastname']
                    ),

                    _form(
                      title: 'อีเมล',
                      content: sn.data['email']
                    ),






                    SizedBox(height: 20.0),

                    rButton(
                  context: context,
                  action: ()=> authService.signout(context),
                  color: Colors.red,
                  text: 'Signout',
                ),
                   

                    
                  ],
                ),
              ),
            );
          },
        ),
      ),
      
    );
  }
}



Widget _form({
    title,
    content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
