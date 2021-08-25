import 'package:auction_app/constants.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/DetailScreen.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Vehicle vehicle;
  static const height = 360.0;
  MyCard(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Column(
            children: [
              Image.network(kURI.toString()+"/vehicle-images/"+vehicle.img),
              Text(vehicle.initial_Price.toString()),
              Text(vehicle.model),
              Text(vehicle.brand),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(vehicle.id)));
          },
          splashColor: Colors.blue,
        ),
      ),
    );
  }
}
