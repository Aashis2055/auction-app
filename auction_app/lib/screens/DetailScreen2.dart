import 'package:auction_app/models/comment.dart';
import 'package:auction_app/models/vehicle_detail_model.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/services/storage.dart';
import 'package:auction_app/widgets/AlertTextField.dart';
import 'package:auction_app/widgets/CommentCard.dart';
import 'package:flutter/material.dart';
//
import '../constants.dart';

class DetailScreen extends StatefulWidget {
  static final String id = "detail_screen";
  final String vId;
  DetailScreen(this.vId);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  VehicleDetail vehicle;
  List<Comment> comments;
  NetworkHelper networkHelper;
  StorageHelper storageHelper;
  int currentBid =0;
  int newBid;
  String uId;
  String vId;
  // TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    storageHelper = StorageHelper();
    setUp();
  }

  void setUp() async {
    // API
    networkHelper = new NetworkHelper(context);
    await networkHelper.initState();
    VDe responseData = await networkHelper.getPost(this.widget.vId);
    bool isUser = false;
    if(responseData.yId == null || responseData.post == null){

    }else if(responseData.post.bid == null){}
    else if(responseData.post.uId == responseData.yId || responseData.post.bid.uID == responseData.yId){
      isUser = true;
    }
    setState(() {
      vehicle = responseData.post;
      comments = responseData.comments;
      currentBid = vehicle.bid == null? vehicle.initialPrice : int.parse(vehicle.bid.price);
    });


  }

  void bid(dynamic data) {}
  @override
  Widget build(BuildContext context) {
    print(currentBid);
    return Scaffold(
        appBar: AppBar(
          title: Text('details'),
        ),
        body: vehicle == null? ProgressScreen(): Container(
            child: Column(
                children: [
                  Image.network(kURI.toString()+"/vehicle-images/"+vehicle.img),
                  Column(
                    children: [
                      Text(vehicle.brand),
                      Text(vehicle.kmDriven),
                      Text(vehicle.model),
                      Text(vehicle.color),
                      Text(vehicle.type)
                    ],
                  )
                ]
            ),
        ),
    );
    }

  @override
  void dispose() {
    // socket.disconnect();
    super.dispose();
  }
}

class AlertVehicleDetails extends StatelessWidget {
  final VehicleDetail vehicle;
  AlertVehicleDetails(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Vehicle Detail'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text("Model :"+vehicle.model),
              Text("Brand :"+vehicle.brand),
              Text("Color :"+vehicle.color),
              Text("Type :"+vehicle.type),
              Text("Year :"+vehicle.year.toString()),
              Text("KM Driven: "+vehicle.kmDriven),
              Text("Initial Price : "+vehicle.initialPrice.toString()),
              Text("Auction End: "+vehicle.endDate)
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK"))
        ],
      ),
    );
  }
}
