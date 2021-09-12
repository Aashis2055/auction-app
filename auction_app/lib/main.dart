import 'package:auction_app/screens/EstimateScreen.dart';
import 'package:auction_app/screens/UploadScreen.dart';
import 'package:flutter/material.dart';
// screens
import './screens/HomeScreen.dart';
import 'package:auction_app/screens/DashBoard.dart';
import 'package:auction_app/screens/LoginScreen.dart';
import 'package:auction_app/screens/RegisterScreen.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/screens/MyPostScreen.dart';
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
        ProfileFrag.id: (context)=> ProfileFrag(),
        MyPosts.id: (context)=> MyPosts(),
        EstimateScreen.id: (context)=> EstimateScreen(),
      },
    );
  }
}
