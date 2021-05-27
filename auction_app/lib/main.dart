import 'package:auction_app/screens/DetailScreen.dart';
import 'package:auction_app/screens/UploadModal.dart';
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
        UploadModal.id: (context) => UploadModal(),
      },
    );
  }
}

class MyCircularProgress extends StatefulWidget {
  @override
  _MyCircularProgressState createState() => _MyCircularProgressState();
}

class _MyCircularProgressState extends State<MyCircularProgress>
    with TickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(10);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Progress indicator'),
        CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Linear Progress indicator',
        )
      ],
    );
  }
}
