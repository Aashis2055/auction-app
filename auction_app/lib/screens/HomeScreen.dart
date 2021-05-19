import 'package:auction_app/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
//
import '../widgets/MyAppBar.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset('images/logo.jpg'),
        ),
        Container(
          child: TextButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        )
      ],
    ));
  }
}
