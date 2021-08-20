import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/LoginScreen.dart';
import 'DashBoard.dart';
//
import 'package:auction_app/services/storage.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    // TODO load image properly and early
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('images/logo.jpg'),
        ),
        Container(child: MyCircularProgress()),
      ],
    ));
  }
}

class MyCircularProgress extends StatefulWidget {
  @override
  _MyCircularProgressState createState() => _MyCircularProgressState();
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  bool status = false;
  @override
  void initState() {
    super.initState();
    StorageHelper storageHelper = StorageHelper();
    Future.delayed(Duration(seconds: 3), () {
      storageHelper.getToken().then((value) {
        // TODO check if the token has expired
        if (value == null) {
          // if there is no token go to login screen
          Navigator.pushNamed(context, LoginScreen.id);
        } else {
          //  if there is token go to the dashboard
          Navigator.pushNamed(context, DashBoard.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
        strokeWidth: 8,
      ),
    );
  }
}
