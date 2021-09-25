import 'package:flutter/material.dart';
import 'package:auction_app/utils/dropdown.dart';

class EstimateScreen extends StatefulWidget {
  static final String id = "estimate_screen";

  @override
  _EstimateScreenState createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  String type = "Bike";
  String color;
  String model;
  String brand;
  String year;
  String kmDriven;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton(
              value: type,
              items: toDropdownMenu(['Car', 'Bike', 'Scooter']),
              onChanged: (value) {
                type = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Enter Color', errorText: 'Invalid color'),
              onChanged: (value) {
                color = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Enter Model', errorText: 'Inalid Mdel'),
              onChanged: (value) {
                model = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Enter Brand', errorText: 'Invalid Brand'),
              onChanged: (value) {
                brand = value;
              },
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: 'Enter Year', errorText: 'Invalid year'),
              onChanged: (value) {
                year = value;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Km Driven', errorText: 'Invalid'),
              onChanged: (value) {
                kmDriven = value;
              },
            ),
            TextButton(onPressed: (){
              // TODO show estimate alert
            }, child: Text("Get Estimation"))
          ],
        ),
      ),
    )
    );
  }
}