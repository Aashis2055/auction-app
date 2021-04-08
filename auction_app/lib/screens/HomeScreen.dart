import 'package:flutter/material.dart';
//
import '../widgets/MyAppBar.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.ac_unit),
          Icon(Icons.access_alarm),
          Icon(Icons.accessibility_outlined)
        ],
      ),
    );
  }
}
