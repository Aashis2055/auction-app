import 'package:auction_app/models/comment.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/services/network.dart';
import 'package:auction_app/services/storage.dart';
import 'package:auction_app/widgets/AlertTextField.dart';
import 'package:auction_app/widgets/CommentCard.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


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
  IO.Socket socket;
  Vehicle vehicle;
  List<Comment> comments;
  NetworkHelper networkHelper;
  StorageHelper storageHelper;
  int currentBid =0;
  int newBid;
  String u_id;
  String vId;
  bool isDisabled = false;
  // TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    storageHelper = StorageHelper();
    setUp();
    // _controller = new TextEditingController(text: (currentBid+5000).toString());
    
  }

  void setUp() async {
    try {
      // api
    networkHelper = new NetworkHelper(context);
    await networkHelper.initState();
    Map<String, dynamic> responseData = await networkHelper.getPost(this.widget.v_id);
    setState(() {
      vehicle = responseData['post'];
      comments = responseData['comments'];
      currentBid = vehicle.bid == null? vehicle.initial_Price : int.parse(vehicle.bid.price);
    });
    socket = IO.io('http://192.168.100.80:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.on('error', (data){
      print(data['msg']);
    });
    socket.onDisconnect((_) => print('disconnect'));

    // emit that a user has joined and get id
      socket.emit('joinRoom', {'token': storageHelper.getToken(), 'v_id':this.widget.v_id});
      // get id after the user joins
      socket.on('getId', (data){
        print('inside get id');
        u_id = data['u_id'];
        // TODO check if the vehicle belong to the auctioner or has the bid price
        // if(vehicle.bid.u_id == u_id || vehicle.uId == u_id){
        //   isDisabled = true;
        // }else{
        //   isDisabled = false;
        // }
      });
      // change price when some one bids
      socket.on('priceChange', (json){
        print('price changed');
        print(json);
        vehicle.initial_Price = json['price'];
        // if(json['newu_id'] == u_id){
        //   setState(() {
        //     isDisabled = true;
        //   });
        // }else{
        //   isDisabled = false;
        // }
      });
    } catch (e) {
      print(e);
    }
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
            TextButton(onPressed: (){
              print(socket.connected);
              showDialog(context: context, builder: (BuildContext context)=> AlertVehicleDetails(vehicle));
            }, child: Text("More Detais",)),
            Row(
              children: [
                Text("Current Bid: "+currentBid.toString()),
                TextButton(
                  onPressed: isDisabled?null:(){
                    showDialog(context: context, builder: (BuildContext context)=>AlertTextField("Bid Your Price", (){
                    // callback function when user presses ok
                      print('emmited');
                    socket.emit('bidPrice', {'newP': 100000});
                  }, (value){
                    // call back function to handle change
                    newBid = value;
                  }, currentBid+5000));
                },
                child: Text('Bid ', style: TextStyle(backgroundColor: Colors.blue, color: Colors.amberAccent),),
                ),
              ],
            ),
            TextButton(onPressed: (){

            }, child: Text('Add Comment')),
            Column(
              children: comments == null || comments.length == 0?
              [Text('No Comments for this post')] :
              comments.map((comment)=>CommentCard(comment))
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
        content: SingleChildScrollView(
          child: Column(
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
