import 'dart:async';
import 'dart:convert';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String email = "user2@email.com";
  String password = "the password";


  @override
  void initState() {
    super.initState();
    NetworkHelper networkHelper = NetworkHelper(context);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background1(
        child: Container(
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Enter Email",
            ),
            onChanged: (value){email = value;},
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Enter Password"
            ),
            onChanged: (value){password = value;},
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              RowButton(
                  label: 'Login',
                  callback: () async {
                    Uri uri = Uri(
                        host: '192.168.10.69',
                        port: 5000,
                        scheme: 'http',
                        path: '/user-api/login');
                    http.Response response = await http.post(uri,
                        body: {'email': email, 'password': password});
                    if (response.statusCode == 200) {
                      StorageHelper storageHelper = StorageHelper();
                      Map data = jsonDecode(response.body);
                      await storageHelper.setToken(data['token']);
                      Navigator.pushNamed(context, DashBoard.id);
                    } else {
                      // TODO show login error
                      Fluttertoast.showToast(msg: 'Error on login');
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
