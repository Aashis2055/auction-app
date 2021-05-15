import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// screens
//widgets
import 'package:auction_app/models/user.dart';
import 'package:auction_app/constants.dart';

class ProfileFrag extends StatefulWidget {
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  User user;
  @override
  void initState() {
    super.initState();
    getProfile();
  }
  void getProfile() async{
    Uri uri = kuri.replace(path: '/user-api/');
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      print(response.body);
    }else{
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('images/logo.jpg'),
          Text('name')
        ],
      ),
    );
  }

}
