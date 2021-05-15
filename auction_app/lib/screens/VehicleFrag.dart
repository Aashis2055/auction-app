import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// screens
// widgets
import 'package:auction_app/widgets/MyCard.dart';
// models
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/constants.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    Uri uri = kuri.replace(path: '/user-api/vehicle',);
    http.Response response = await http.get(uri, headers: {
      'authorization': token
    });
    if(response.statusCode == 200){
      print(response.body);
    }else{
      print('error');
    }

  }
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

