import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_it/views/create_group.dart';
import 'package:stock_it/views/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            CreateGroup(),
            Container(
              color: Colors.amber,
            ),
            Container(
              color: Colors.pink,
            ),
            // Container(
            //   color: Colors.greenAccent,
            // ),
            ProfileScreen(),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('หน้าแรก',),
            icon: Icon(FontAwesomeIcons.home),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'ประวัติ',
            ),
            icon: Icon(FontAwesomeIcons.chartBar),
            activeColor: Colors.red,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'แนะนำ',
            ),
            icon: Icon(FontAwesomeIcons.clipboardList),
            activeColor: Colors.deepPurple,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'ตั้งค่า',
            ),
            icon: Icon(FontAwesomeIcons.cog),
            inactiveColor: Colors.grey[600],
          ),
        ],
      ),
    ),
    );
  }
}
