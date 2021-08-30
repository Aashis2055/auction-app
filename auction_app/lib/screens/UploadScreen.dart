import 'package:auction_app/screens/UploadScreen2.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/utils/dropdown.dart';

class UploadScreen extends StatefulWidget {
  static final String id = "upload_screen";

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String type = "Bike";
  String color;
  String model;
  String brand;
  String year;
  String kmDriven;
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('upload'),
        ),
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
              Navigator.push(
                context, MaterialPageRoute(builder: (context)=>UploadScreen2(brand: brand, type: type, color: color, model: model, year: year,)));
            }, child: Text("Continue"))
          ],
        ),
      )
      ),
    );
  }
}
