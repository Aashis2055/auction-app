import 'package:auction_app/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
// screens
// widgets
import 'package:auction_app/widgets/MyCard.dart';
// models
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/services/network.dart';

class VehiclesFrag extends StatefulWidget {
  @override
  _VehiclesFragState createState() => _VehiclesFragState();
}

class _VehiclesFragState extends State<VehiclesFrag> {
  NetworkHelper networkHelper;
  List<Vehicle> posts = [
    Vehicle(
      type: 'Scooter',
      initial_Price: 50000,
      color: 'Red',
    ),
    Vehicle(
      type: 'Scooter',
      initial_Price: 50000,
      color: 'Red',
    ),
    Vehicle(
      type: 'Scooter',
      initial_Price: 50000,
      color: 'Red',
    ),
    Vehicle(
      type: 'Scooter',
      initial_Price: 50000,
      color: 'Red',
    ),
  ];
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    await networkHelper.initState();
    List<Vehicle> myPosts = await networkHelper.getPosts();
    if (myPosts == null) {
      return;
    }
    // setState(() {
    //   posts = myPosts;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: ListView.builder(
      //     itemCount: posts.length,
      //     itemBuilder: (context, index) => MyCard(posts[index])),
    );
  }
}
