import 'package:auction_app/constants.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
//
import 'package:auction_app/utils/dateformatter.dart';
class MyCard2 extends StatelessWidget {
  final Vehicle vehicle;
  static const height = 360.0;
  MyCard2(this.vehicle);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Model",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 18),
                  ),
                  // Spacer(flex: 1,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Text(
                            vehicle.model
                        )
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "auction date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 18),
                  ),
                  // Spacer(flex: 1,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Text(
                            formatDate(vehicle.auctionDate)
                        )
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brand",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 18),
                  ),
                  // Spacer(flex: 1,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Text(
                            vehicle.brand
                        )
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vehicle.location.district,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 18),
                  ),
                  // Spacer(flex: 1,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Text(
                            vehicle.kmDriven.toString()
                        )
                    ),
                  )
                ],
              )
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
