import 'package:flutter/material.dart';
// screens
//widgets
import 'package:auction_app/models/user.dart';
import 'package:auction_app/services/network.dart';

class ProfileFrag extends StatefulWidget {
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  User user;
  NetworkHelper networkHelper;
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    await networkHelper.initState();
    User myUser = await networkHelper.getProfile();
    if (myUser == null) {
      return;
    }
    setState(() {
      user = myUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Image.asset('images/logo.jpg'), Text('name')],
      ),
    );
  }
}
