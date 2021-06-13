import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String description;
  int initialPrice;
  DateTime auctionDate;
  DateTime endDate;
  String fileName = "Not Selected";
  String filePath;
  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('upload'),
        ),
        body: Column(
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
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Enter Description', errorText: 'Invalid'),
              onChanged: (value) {
                description = value;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Initial Price', errorText: 'Invalid'),
              onChanged: (value) {
                initialPrice = 0;
              },
            ),
            TextButton(
                onPressed: () async {
                  auctionDate = await _selectDate(context);
                },
                child: Text('Select Auction Date')),
            TextButton(
                onPressed: () async {
                  endDate = await _selectDate(context);
                },
                child: Text('Select Auction Date')),
            TextButton(
              child: Text('Choose Image'),
              onPressed: () async {
                // TODO pick file
                FilePickerResult result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'jpeg']);
                if (result != null) {
                  PlatformFile file = result.files.first;
                  print(file.name);
                  print(file.path);
                } else {
                  Fluttertoast.showToast(
                      msg: 'something went wrong on imag pick');
                }
              },
            ),
            Text(fileName),
            TextButton(
              child: Text('Upload'),
              onPressed: () async {
                // TODO upload post
                FormData formData = FormData.fromMap({
                  'type': type,
                  'color': color,
                  'model': model,
                  'brand': brand,
                  'year': year,
                  'km_driven': kmDriven,
                  'description': description,
                  'initial_price': initialPrice,
                  'auction_date': auctionDate.toString(),
                  'end_date': endDate.toString(),
                  "file":
                      await MultipartFile.fromFile(filePath, filename: fileName)
                });
                var dio = Dio();
                var response =
                    await dio.post("http://localhost:5000/user-api/vehicle");
                if (response.statusCode == 200) {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Error on upload");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
