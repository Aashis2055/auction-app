import 'package:auction_app/constants.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/widgets/MyCard.dart';
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
  User user = null;
  List<Vehicle> posts;
  NetworkHelper networkHelper;
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    print('the profile');
    await networkHelper.initState();
    Map data = await networkHelper.getProfile();
    if (data['user'] == null) {
      return;
    } else {
      setState(() {
        user = data['user'];
        posts = data['posts'];
      });
      print(user.firstName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: user == null
          ? ProgressScreen()
          : Column(
              children: [
                Image.network('http://$kIP:5000/profile-image/${user.img}'),
                Text('User Detail'),
                Text('name'),
                Text('Name: ${user.firstName}'),
                Text('Last Name: ${user.lastName}'),
                Text('Email: ${user.email}'),
                Text('Phone No: ${user.phoneNo}'),
                !user.status
                    ? Text(
                        'Status: Active',
                        style: TextStyle(backgroundColor: Colors.green),
                      )
                    : Text(
                        'Status: Inactive',
                        style: TextStyle(backgroundColor: Colors.red),
                      ),
                ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return MyCard(posts[index]);
                  },
                )
              ],
            ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [CircularProgressIndicator(), Text('Loading ...')],
        ),
      ),
    );
  }
}
