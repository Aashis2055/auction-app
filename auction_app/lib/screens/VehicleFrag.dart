import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/DetailScreen.dart';
import 'package:auction_app/widgets/MyCard.dart';
import 'package:flutter/material.dart';

class VehiclesFrag extends StatefulWidget {
  @override
  _VehiclesFragState createState() => _VehiclesFragState();
}

class _VehiclesFragState extends State<VehiclesFrag> {
  List<Vehicle> my_Posts = [
    Vehicle(type: 'Scooter', initial_Price: 50000, color: 'Red', ),
    Vehicle(type: 'Scooter', initial_Price: 50000, color: 'Red', ),
    Vehicle(type: 'Scooter', initial_Price: 50000, color: 'Red', ),
    Vehicle(type: 'Scooter', initial_Price: 50000, color: 'Red', ),

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: my_Posts.length,
          itemBuilder: (context, index)=> MyCard(
            img: my_Posts[index].img,
            model: 'H',
            color: my_Posts[index].color,
            price: my_Posts[index].initial_Price,
            type: my_Posts[index].type,
            callback: (){
              // Navigator.push(context, );
            },
          )
      ),
    );
  }
}

