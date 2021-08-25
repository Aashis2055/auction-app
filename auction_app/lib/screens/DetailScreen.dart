import 'package:auction_app/models/comment.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/services/storage.dart';
import 'package:auction_app/widgets/AlertTextField.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
//
import '../constants.dart';

class DetailScreen extends StatefulWidget {
  static final String id = "detail_screen";
  final String v_id;

  DetailScreen(this.v_id);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Socket socket;
  Vehicle vehicle;
  List<Comment> comments;
  NetworkHelper networkHelper;
  StorageHelper storageHelper;
  int currentBid;
  int newBid;
  String u_id;
  bool isDisabled = true;
  // TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    setUp();
    // _controller = new TextEditingController(text: (currentBid+5000).toString());
    
  }

  void setUp() async {
    try {
      socket = io('http://$kIP:5000', <String, dynamic>{
        'transport': ['websocket'],
        'autoConnect': false
      });
      socket.onconnect();
      socket.onConnect((data) {
        print('on connect called');
        print(data);
      });
    networkHelper = new NetworkHelper(context);
    await networkHelper.initState();
    
    Map<String, dynamic> responseData = await networkHelper.getPost(this.widget.v_id);
    print(responseData);
    setState(() {
      vehicle = responseData['post'];
      comments = responseData['comments'];
    });
    currentBid = vehicle.bid == null? vehicle.initial_Price : vehicle.bid.price;

    // socket connection


      // emit that a user has joined and get id
      socket.emit('joinRoom', {'token': storageHelper.getToken(), 'v_id':this.widget.v_id});
      // get id after the user joins
      socket.on('getId', (data){
        u_id = data['u_id'];
      });
      // change price when some one bids
      socket.on('priceChange', (json){
        print(json);
        vehicle.initial_Price = json['price'];
        if(json['newu_id'] == u_id){
          setState(() {
            isDisabled = true;
          });
        }
      });
      socket.on('error', (data){
        print(data['msg']);
      });
    } catch (e) {
      print(e);
    }
  }

  void bid(dynamic data) {}

  @override
  Widget build(BuildContext context) {
    print(vehicle);
    return Scaffold(
      appBar: AppBar(
        title: Text('details'),
      ),
      body: vehicle == null? ProgressScreen(): Container(
        child: Column(
          children: [
            Image.network(kURI.toString()+"/vehicle-images/"+vehicle.img),
            TextButton(onPressed: (){
              // TODO show alert dialog for details
              
            }, child: Text("More Detais",)),
            Row(
              children: [
                Text("Current Bid: "+currentBid.toString()),
                TextButton(
                  onPressed: isDisabled?null:(){
                    // TODO show alert text field
                    showDialog(context: context, builder: (BuildContext context)=>AlertTextField("Bid Your Price", (){
                    // callback function when user presses ok
                    socket.emit('bidPrice', {'newP': newBid});
                  }, (value){
                    // call back function to handle change
                    newBid = value;
                  }, currentBid+5000));
                },
                child: Text('Bid '+(currentBid+5000).toString()),
                ),

              ],
            )
            ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}

class AlertVehicleDetails extends StatelessWidget {
  final Vehicle vehicle;
  AlertVehicleDetails(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Vehicle Detail'),
        content: Column(
          children: [
            Text("Model :"+vehicle.model),
            Text("Brand :"+vehicle.brand),
            Text("Color :"+vehicle.color),
            Text("Type :"+vehicle.type),
            Text("Year :"+vehicle.year.toString()),
            Text("KM Driven: "+vehicle.kmDriven),
            Text("Initial Price : "+vehicle.initial_Price.toString()),
            Text("Auction End: "+vehicle.endDate)
          ],
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
