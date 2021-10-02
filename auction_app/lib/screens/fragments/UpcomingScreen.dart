import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/widgets/MyCard2.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  NetworkHelper networkHelper;
  List<Vehicle> posts;
  @override
  void initState() {
    networkHelper = NetworkHelper(context);
    super.initState();
    setUp();
  }
  setUp() async {
    await networkHelper.initState();
    List<Vehicle> myPosts = await networkHelper.getUpcomingPosts();
    print(myPosts);
    if (myPosts == null) {
      return;
    } else {
      setState(() {
        posts = myPosts;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: posts ==null? ProgressScreen() : 
      Column(
        children: posts.length == 0?[
          Text('No Upcoming on the posts yet')
        ]: posts.map((e) => MyCard2(e)).toList()
      )
    );
  }
}
//RenderBox was not laid out: RenderFlex#89876 relayoutBoundary=up1 NEEDS-PAINT