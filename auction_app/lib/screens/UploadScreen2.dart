import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:auction_app/services/network.dart';

class UploadScreen2 extends StatefulWidget {
  final String type;
  final String color;
  final String model;
  final String brand;
  final String year;
  final String kmDriven;
  UploadScreen2({this.brand, this.type, this.color, this.kmDriven, this.model, this.year});

  @override
  _UploadScreen2State createState() => _UploadScreen2State();
}

class _UploadScreen2State extends State<UploadScreen2> {
  String description;
  int initialPrice;
  DateTime auctionDate;
  DateTime endDate;
  String fileName = "Not Selected";
  String filePath;
  String predictionPrice;
  NetworkHelper  networkHelper;
  @override
  void initState() {
    super.initState();
    setUp();
    // _controller = new TextEditingController(text: (currentBid+5000).toString());
    
  }
  void setUp()async{
     networkHelper = new NetworkHelper(context);
     await networkHelper.initState();
     // String predictionResult = await networkHelper.getPrediction(this.widget.model, this.widget.year, this.widget.brand, this.widget.kmDriven);
     // setState(() {
     //   predictionPrice = predictionResult;
     // });

  }
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
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                  labelText: 'Initial Price', errorText: 'Invalid', hintText: predictionPrice),
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
                  print('error on image pick');
                }
              },
            ),
            Text(fileName),
            TextButton(
              child: Text('Upload'),
              onPressed: () async {
                // TODO upload post
                FormData formData = FormData.fromMap({
                  'type': this.widget.type,
                  'color': this.widget.color,
                  'model': this.widget.model,
                  'brand': this.widget.brand,
                  'year': this.widget.year,
                  'km_driven': this.widget.kmDriven,
                  'description': description,
                  'initial_price': initialPrice,
                  'auction_date': auctionDate.toString(),
                  'end_date': endDate.toString(),
                  "file":
                      await MultipartFile.fromFile(filePath, filename: fileName)
                });
                networkHelper.postProduct(formData);
              },
            )
            ],
          ),
        ),
      ),
    );
      
  }
}