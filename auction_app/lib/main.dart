import 'package:flutter/material.dart';
// screens
import './screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Auction',
      home: HomeScreen(),
      initialRoute: HomeScreen.id,
      routes: {HomeScreen.id: (context) => HomeScreen()},
    );
  }
}
