
import 'package:auction_app/views/view1.dart';
import 'package:auction_app/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String phoneNo = "";
  int index = 0;
  Map<String, String> errors = {
    'email': '',
    'password': '',
    'first_name': '',
    'last_name': '',
    'phone_no': ''
  };

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
              labelText: 'Your Email',
              hintText: 'Enter Email',
              errorText: errors['email']),
          onChanged: (value) {
            email = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              icon: Icon(Icons.security),
              labelText: 'Password',
              hintText: 'Enter Password',
              errorText: errors['password']),
          onChanged: (value) {
            password = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              icon: Icon(Icons.verified_user),
              labelText: 'First Name',
              hintText: 'Enter First Name',
              errorText: errors['first_name']),
          onChanged: (value) {
            firstname = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              icon: Icon(Icons.verified_user),
              labelText: 'Last Name',
              hintText: 'Enter Last Name',
              errorText: errors['last_name']),
          onChanged: (value) {
            lastname = value;
          },
        ),

        DropdownButton(value: province, items: toDropdownMenu(kProvince), onChanged: (value){

          setState(() {
            province = value;
            index = kProvince.indexOf(value);
            district = kDistrict[index][0];
          });

        },),

        DropdownButton<String>(
          value: district,
          style: TextStyle(color: Colors.black),
          items: toDropdownMenu(kDistrict[index]),
          onChanged: (value){
            district = value;
          },
        ),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              icon: Icon(Icons.phone),
              labelText: 'Phone No',
              hintText: 'Enter Phone No',
              errorText: errors['phone_no'],
          ),
          onChanged: (value){
            phoneNo = value;
          },
        ),
        RowButton(
            label: 'Register',
            callback: () async {
              // TODO validate data
              bool isValid = true;
              // email validation
              if (email == '') {
                errors['email'] = 'Enter Valid Email';
                isValid = false;
              }
              // password validation
              if (password == '') {
                errors['password'] = 'Please Enter Password';
                isValid = false;
              } else if (password.length <= 8) {
                errors['password'] =
                    'Password must be greater than 8 Characters';
                isValid = false;
              }
              // check if the values are valid
              // if not valid end
              if (!isValid) return;
              Uri uri = kURI.replace(path: '/user-api/register');
              var postBody = {
                'email': email,
                'first_name': firstname,
                'last_name': lastname,
                'password': password,
                  'district': district,
                  'province': province,
                'phone_no': phoneNo
              };
              http.Response response = await http.post(uri, body: postBody,);
              if (response.statusCode == 200) {
                Navigator.pushNamed(context, LoginScreen.id);
              } else if (response.statusCode == 500) {
                showDialog(context: context, builder: (BuildContext context)=> MyAlertDialog("Server Error Please Try Again"));
              } else {
                showDialog(context: context, builder: (BuildContext context)=> MyAlertDialog(response.body.toString()));
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
