import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:flutter/material.dart';
// widgets
import 'package:auction_app/widgets/MyCard.dart';
// models
import 'package:auction_app/models/vehicle_model.dart';

class VehiclesFrag extends StatelessWidget {
  
  final List<Vehicle> posts;
  VehiclesFrag(this.posts);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: posts == null? ProgressScreen() : Text(posts.toString())
    );
  }
}
// ListView.builder(
// itemCount: posts.length,
// itemBuilder: (context, index) => MyCard(
// posts[index],
// )),