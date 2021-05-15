import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// screens
import 'package:auction_app/screens/RegisterScreen.dart';
import '../constants.dart';
import 'DashBoard.dart';
import 'package:auction_app/views/view1.dart';
// widgets
import 'package:auction_app/widgets/TextFields.dart';
import 'package:auction_app/widgets/RowButton.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "email2@email.com";
  String password = "the password";

  changeEmail(value) {
    setState(() {
      email = value;
    });
  }

  void changePassword(value) {
    password = value;
  }

  @override
  Widget build(BuildContext context) {
    return Background1(
        child: Container(
      child: Column(
        children: [
          EmailTextField(changeEmail),
          PasswordTextField(changePassword),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              RowButton(
                  label: 'Login',
                  callback: () async {
                    Uri uri = Uri(host: '192.168.10.69', port: 5000, scheme: 'http', path: '/user-api/login');
                    http.Response response = await http.post(uri, body: {
                      'email': email,
                      'password': password
                    });
                    print(response.body);
                    if(response.statusCode == 200){
                      // TODO save token
                      Navigator.pushNamed(context, DashBoard.id);
                    }else{
                      // TODO show login error
                    }
                  })
            ],
          ),
          RowButton(
              label: 'Register',
              callback: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              })
        ],
      ),
    ));
  }
}
