import 'package:auction_app/models/comment.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/services/storage.dart';
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
  String u_id;
  bool isDisabled;
  @override
  void initState() {
    super.initState();
    setUp();
  }

  void setUp() async {
    networkHelper = new NetworkHelper(context);
    await networkHelper.initState();
    
    Map<String, dynamic> responseData = await networkHelper.getPost(this.widget.v_id);
    setState(() {
      vehicle = responseData['post'];
      comments = responseData['comments'];
    });
    
    try {
      socket = io('http://$kIP:5000', <String, dynamic>{
        'transport': ['websocket'],
        'autoConnect': false
      });
      socket.onconnect();
      socket.onConnect((data) {
        print(data);
      });
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
    int currentBid = vehicle.bid == null? vehicle.initial_Price : vehicle.bid.price;
    return Scaffold(
      appBar: AppBar(
        title: Text('details'),
      ),
      body: Container(
        child: Column(
          children: [
            Icon(Icons.access_time_sharp),
            Text("Model"),
            Row(
              children: [
                vehicle.bid == null ? Text('No Bid Yet') :Text('Current Bid:'),
                TextButton(
                  onPressed: isDisabled?null:(){
                  socket.emit('bidPrice', {'newP': currentBid+5000});
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
