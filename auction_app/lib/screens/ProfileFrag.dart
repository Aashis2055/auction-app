import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  void getData(){
    Uri uri = Uri();
    http.get(uri, headers: {

    }, );
  }
}
