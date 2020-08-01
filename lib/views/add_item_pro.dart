import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPro extends StatefulWidget {
  final docsID;

  const AddItemPro({Key key, this.docsID}) : super(key: key);
  @override
  _AddItemProState createState() => _AddItemProState();
}

class _AddItemProState extends State<AddItemPro> {
  bool loading;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController detailCtrl = new TextEditingController();
  TextEditingController priceCtrl = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  Firestore firestore = Firestore.instance;
  String uid;
  Future<File> file;
  File tmpFile;
  String imgUrl;

  userId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uuid = user.uid.toString();
    print(uuid);
    setState(() {
      uid = uuid;
    });
  }

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

  addItem() async {
    String name = nameCtrl.text;
    String detail = detailCtrl.text;
    String price = priceCtrl.text;

    print('$name, $detail, $price');

    await uploadImage();

    firestore
        .collection('users')
        .document(uid)
        .collection('groups')
        .document(widget.docsID)
        .collection('proitem')
        .add({'name': name, 'detail': detail, 'price': price, 'img': imgUrl})
        .then((value) => debugPrint('$value'))
        .catchError((e) => debugPrint('Err: $e'));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    userId();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Item'),
          centerTitle: true,
        ),
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
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: detailCtrl,
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Detail',
                        ),
                      ),
                      TextFormField(
                        controller: priceCtrl,
                        decoration: InputDecoration(
                          icon: Icon(Icons.shop_two),
                          labelText: 'Price',
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          addItem();
                        },
                        child: Text('Add Item'),
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
