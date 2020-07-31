import 'package:flutter/material.dart';
import 'package:stock_it/views/create_group_screen.dart';
import 'package:stock_it/views/profile_screen.dart';
import 'package:stock_it/views/view_group_screen.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Group'),
          centerTitle: true,
        ),
        body: CreateGroupScreen(),
        drawer: Drawer(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'SHOP SHIRT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dw.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              


              // Padding(
              //   padding: EdgeInsets.only(top: 8.0),
              //   child: Container(
              // decoration: BoxDecoration(
              //   color: Colors.blue[100],
              // ),
              // child: ListTile(
              //   title: Text(
              //     'Add Product',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 20.0,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProductScreen()));
              //   },
              // ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
              child: ListTile(
                title: Text(
                  'View Group',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewGroupScreen()));
                },
              ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                color: Colors.blue[100],
                  ),
                  child: ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(
                      'logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
