import 'package:auction_app/screens/DetailScreen.dart';
import 'package:auction_app/screens/UploadScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
// screens
import './screens/HomeScreen.dart';
import 'package:auction_app/screens/DashBoard.dart';
import 'package:auction_app/screens/LoginScreen.dart';
import 'package:auction_app/screens/RegisterScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Auction',
      home: HomeScreen(),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        DashBoard.id: (context) => DashBoard(),
        UploadScreen.id: (context) => UploadScreen(),
      },
    );
  }
}
