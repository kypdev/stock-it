import 'package:flutter/material.dart';
import 'package:stock_it/views/home_drawer.dart';
import 'package:stock_it/views/login_screen.dart';
import 'package:stock_it/views/signup_screen.dart';
import 'package:stock_it/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Kanit',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeDrawer(),
      },
    );
  }
}
