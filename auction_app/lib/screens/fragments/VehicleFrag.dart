import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/services/network.dart';
import 'package:flutter/material.dart';
// widgets
import 'package:auction_app/widgets/MyCard.dart';
// models
import 'package:auction_app/models/vehicle_model.dart';

class VehiclesFrag extends StatefulWidget {
  @override
  _VehiclesFragState createState() => _VehiclesFragState();
}

class _VehiclesFragState extends State<VehiclesFrag> {
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
    List<Vehicle> myPosts = await networkHelper.getPosts();
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
      child: posts == null? ProgressScreen() : Column(
        children: posts.length == 0?[
          Text('No post to show')
        ] : posts.map((post)=> MyCard(post)).toList(),
      )
    );
  }
}
// ListView.builder(
// itemCount: posts.length,
// itemBuilder: (context, index) => MyCard(
// posts[index],
// )),