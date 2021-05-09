import 'package:auction_app/views/view1.dart';
import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/LoginScreen.dart';
// widgets
import 'package:auction_app/widgets/RowButton.dart';
import 'package:auction_app/widgets/TextFields.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String password = "";
  String email = "";
  void setPassword(value){
    setState(() {
      password = value;
    });
  }
  void setEmail(value){
    email = value;
  }

  @override
  Widget build(BuildContext context) {
    return Background1(
        child: Column(
          children: [
            EmailTextField(setEmail),
            PasswordTextField(setPassword),
            RowButton(label: 'Register', callback: (){
              // TODO Register
            }),
            RowButton(label: 'Login', callback: (){
              // TODO navigate login screen
              Navigator.pushNamed(context, LoginScreen.id);
            })
          ],
        )
    );

  }
}


