import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading;
  TextEditingController groupNameCtrl = new TextEditingController();
  TextEditingController productDetailCtrl = new TextEditingController();
  TextEditingController itemProductCtrl = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;
  Future<File> file;
  File tmpFile;
  String imgUrl;

  void chooseImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('กล้อง'),
                  onTap: () {
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.camera);
                    });
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('คลังรูปภาพ'),
                  onTap: () {
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.gallery);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          // base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(
                    snapshot.data,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://telugukshatriyamatrimony.com/img/no_image_startup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${Path.basename(tmpFile.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(tmpFile);
    await uploadTask.onComplete;
    print('upload success');
    imgUrl = await storageReference.getDownloadURL();
    print('get img url success');
  }

  createGroup() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState.validate()) {
      // print('create group');

      user = await auth.currentUser();
      var uid = user.uid;
      String groupName = groupNameCtrl.text;
      String productDetail = productDetailCtrl.text;
      String productItem = itemProductCtrl.text.trim();

      await uploadImage();
      print('value: $groupName, $productDetail, $productItem');

      firestore
          .collection('users')
          .document(uid)
          .collection('groups')
          .add(
              {'name': groupName, 'detail': productDetail, 'item': productItem, 'img': imgUrl})
          .then((value) => debugPrint('$value'))
          .catchError((e) => debugPrint('Err: $e'));
          setState(() {
      loading = false;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    imgUrl = null;
    tmpFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Create Group'),
        //   centerTitle: true,
        //   actions: <Widget>[
        //     IconButton(
        //         icon: Icon(Icons.ac_unit),
        //         onPressed: () {
        //           print('valud: $imgUrl');
        //           print('valud2: $tmpFile');
        //         }),
        //   ],
        // ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 12.0),
                      showImage(),
                      SizedBox(height: 12.0),
                      RaisedButton(
                        onPressed: () => chooseImage(context),
                        child: Text('Choose Image'),
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        controller: groupNameCtrl,
                        validator: (value) {
                          if (value.isEmpty) return 'Group name is empty!!';
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Group Name',
                        ),
                      ),
                      TextFormField(
                        controller: productDetailCtrl,
                        validator: (value) {
                          if (value.isEmpty) return 'Product detail is empty!!';
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Product details!!',
                        ),
                      ),
                      TextFormField(
                        controller: itemProductCtrl,
                        validator: (value) {
                          if (value.isEmpty) return 'Item product is empty!!';
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Item product',
                        ),
                      ),
                      SizedBox(height: 40.0),
                      RaisedButton(
                        onPressed: () {
                          createGroup();
                        },
                        child: Text('Create Group'),
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(visible: loading, child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
