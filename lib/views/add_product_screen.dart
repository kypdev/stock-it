import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_it/views/do_add_product.dart';
import 'package:stock_it/widget/group_card.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;
  String uid;

  userId() async {
    user = await auth.currentUser();
    uid =  user.uid;
  }

  @override
  void initState() {
    super.initState();
    userId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  debugValue() {
    print('debug: $uid');
  }

  addProduct() async {
    print('add product');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoAddProduct()));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.ac_unit), onPressed: (){
              debugValue();
            },),
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
                        text: docs['name'],
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
                    text: docs['name'],
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
