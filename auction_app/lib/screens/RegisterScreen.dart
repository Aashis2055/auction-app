import 'package:auction_app/views/view1.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// screens
import 'package:auction_app/screens/LoginScreen.dart';
// widgets
import 'package:auction_app/widgets/RowButton.dart';
import 'package:auction_app/widgets/TextFields.dart';
import 'package:auction_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String password = "";
  String email = "";
  String firstname = "";
  String _province = "";
  String _district = "";
  int index = 0;
  void setPassword(value) {
    setState(() {
      password = value;
    });
  }

  void setEmail(value) {
    email = value;
  }

  @override
  Widget build(BuildContext context) {
    return Background1(
        child: Column(
      children: [
        EmailTextField(setEmail),
        PasswordTextField(setPassword),
        TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(Icons.verified_user),
                labelText: 'Enter First Name',
                errorText: 'Invalid Name')),
        TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(Icons.verified_user),
                labelText: 'Enter Last Name',
                errorText: 'Invalid Name')),
        DropdownButton<String>(
          value: _province,
          style: TextStyle(color: Colors.black),
          items: kProvince
              .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  )),
        ),
        DropdownButton<String>(
          value: _district,
          style: TextStyle(color: Colors.black),
          items: kDistrict[index]
              .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  )),
        ),
        RowButton(
            label: 'Register',
            callback: () async {
              Uri uri = kURI.replace(path: '/user-api/register');
              http.Response response = await http
                  .post(uri, body: {'email': email, 'firstname': firstname});
              if (response.statusCode == 200) {
                Navigator.pushNamed(context, LoginScreen.id);
              } else if (response.statusCode == 500) {
                Fluttertoast.showToast(
                    msg: "Server Error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "Server Error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }),
        RowButton(
            label: 'Login',
            callback: () {
              // TODO navigate login screen
              Navigator.pushNamed(context, LoginScreen.id);
            })
      ],
    ));
  }
}
