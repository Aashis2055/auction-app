import 'package:auction_app/views/view1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// screens
import 'package:auction_app/screens/LoginScreen.dart';
// widgets
import 'package:auction_app/widgets/RowButton.dart';
import 'package:auction_app/constants.dart';
import 'package:auction_app/utils/dropdown.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String password = "";
  String email = "";
  String firstname = "";
  String province = kProvince[0];
  String district = kDistrict[0][0];
  String lastname = "";
  int phoneNo = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Background1(
        child: SingleChildScrollView(
            child: Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Enter Email',
              errorText: 'Invalid Email'),
          onChanged: (value) {
            email = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              icon: Icon(Icons.security),
              labelText: 'Enter Password',
              errorText: 'Invalid Password'),
          onChanged: (value) {
            password = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              icon: Icon(Icons.verified_user),
              labelText: 'Enter First Name',
              errorText: 'Invalid Name'),
          onChanged: (value) {
            firstname = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              icon: Icon(Icons.verified_user),
              labelText: 'Enter Last Name',
              errorText: 'Invalid Name'),
          onChanged: (value) {
            lastname = value;
          },
        ),

        DropdownButton(value: province, items: toDropdownMenu(kProvince)),
        // DropdownButton<String>(
        //   value: _province,
        //   style: TextStyle(color: Colors.black),
        //   items: toDropdownMenu(kProvince),
        //   onChanged: (value){
        //     print(value);
        //   },
        // ),
        // DropdownButton<String>(
        //   value: _district,
        //   style: TextStyle(color: Colors.black),
        //   items: kDistrict[index]
        //       .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
        //             value: value,
        //             child: Text(value),
        //           )).toList(),
        // ),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              icon: Icon(Icons.phone),
              labelText: 'Enter Phone No',
              errorText: 'Invalid Phone no'),
        ),
        RowButton(
            label: 'Register',
            callback: () async {
              Uri uri = kURI.replace(path: '/user-api/register');
              http.Response response = await http.post(uri, body: {
                'email': email,
                'first_name': firstname,
                'last_name': lastname,
                'password': password,
                'address': {'province': province, 'district': district},
                'phone_no': phoneNo
              });
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
              Navigator.pushNamed(context, LoginScreen.id);
            })
      ],
    )));
  }
}
