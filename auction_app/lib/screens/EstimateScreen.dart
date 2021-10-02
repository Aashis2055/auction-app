import 'package:auction_app/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/utils/dropdown.dart';
import 'package:flutter/services.dart';
class EstimateScreen extends StatefulWidget {
  static final String id = "estimate_screen";

  @override
  _EstimateScreenState createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  List<String> typeList = ["Car", "Bike", "Scooter"];
  List<String> brandsList = ["Select Type First"];
  List<String> modelsList = ["Select Model First"];
  String currentType;
  String currentModel;
  String currentBrand;
  NetworkHelper networkHelper;
  String predictionPrice;
  int year;
  int kmDriven;
  @override
  void initState() {
    super.initState();
    currentType = typeList[0];
    currentBrand = brandsList[0];
    currentModel = modelsList[0];
    setUp();
  }
  void setUp()async{
     networkHelper = new NetworkHelper(context);
     await networkHelper.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(title: Text("Estimate"),),
        body: Container(
          child: Column(
            children: [
              DropdownButton<String>(
                value: currentType,
                style: TextStyle(color: Colors.green),
                items: toDropdownMenu(typeList),
                onChanged: (value)async{
                  currentType = value;
                  List<String> availableBrands = await networkHelper.getAvailabeBrands(currentType);
                  if(availableBrands.length == 0){
                    return;
                  }
                  setState(() {
                    currentBrand = availableBrands[0];
                    brandsList = availableBrands;

                  });
                },
              ),
              DropdownButton<String>(
                value: currentBrand,
                style: TextStyle(color: Colors.green),
                items: toDropdownMenu(brandsList),
                onChanged: (value)async{
                  currentBrand = value;
                  List<String> availableModels = await networkHelper.getAvailableModels(currentBrand);
                  if(availableModels.length == 0){
                    print("not models");
                    return;
                  }
                  setState(() {
                    currentModel = availableModels[0];
                    modelsList = availableModels;
                  });
                },
              ),
              DropdownButton<String>(
                value: currentModel,
                style: TextStyle(color: Colors.green),
                items: toDropdownMenu(modelsList),
                onChanged: (value){
                  currentModel = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.verified_user),
                      labelText: 'Year',
                      hintText: 'Year of Purchase',),
                  onChanged: (value) {
                    year = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.verified_user),
                    labelText: 'Odometer',
                    hintText: 'Km Driven',),
                  onChanged: (value) {
                    kmDriven = int.parse(value);
                  },
                ),
              ),
              TextButton(onPressed: ()async{
                Map<String, dynamic> result = await networkHelper.getPrediction(
                    model: this.currentModel,
                  year: this.year,
                  brand: this.currentBrand,
                  type: this.currentType,
                  kmDriven: this.kmDriven
                );
                if(result == null){
                  showDialog(context: context, builder: (BuildContext context)=> MyAlertDialog("Sorry cound not get estimation"));
                }else{
                  showDialog(context: context, builder: (BuildContext context)=> AlertEstimate(result));
                }
              }, child: Text("Estimate")
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertEstimate extends StatelessWidget {
  final Map<String, dynamic> message;
  AlertEstimate(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("Estimate Price For", style: TextStyle(color: Colors.green),),
        content: Container(
          child: Column(
            children: [
              Text(this.message['specs']['brand'].toString().toUpperCase()),
              Text(this.message['specs']['model'].toString().toUpperCase()),
              Text("Rs: "+this.message['predictPrice'].toString()),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}