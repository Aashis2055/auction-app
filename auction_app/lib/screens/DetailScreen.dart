import 'package:auction_app/models/comment.dart';
import 'package:auction_app/models/vehicle_detail_model.dart';
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
  final String vId;
  DetailScreen(this.vId);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  IO.Socket socket;
  VehicleDetail vehicle;
  List<Comment> comments;
  NetworkHelper networkHelper;
  StorageHelper storageHelper;
  int currentBid =0;
  int newBid;
  String uId;
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
 /*   socket = IO.io('http://$kIP:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data){
      print('finally connected');
    });
    socket.emit('getId', "hi");
    print(socket.connected);
try{
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
          vehicle.initialPrice = json['price'];
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
       */
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
      isDisabled = isUser;
    });
    print(responseData.yId);
    print(comments.toString());

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
              // print(socket.connected);
              showDialog(context: context, builder: (BuildContext context)=> AlertVehicleDetails(vehicle));
            }, child: Text("More Details",)),
            Row(
              children: [
                Text("Current Bid: "+currentBid.toString()),
                TextButton(
                  onPressed: isDisabled?null:() {
                    showDialog(context: context, builder: (BuildContext context)=>AlertTextField("Bid Your Price", ()async{
                    // callback function when user presses ok
                      print(widget.vId);
                      print(newBid);
                      bool postResult = await networkHelper.postBid(widget.vId, newBid);
                      if(postResult){
                        setState(() {
                          currentBid = newBid;
                          isDisabled = true;
                        });
                      }else{
                        print('Post Failed');
                      }
                      // if(socket.connected){
                      //   socket.emit('bidPrice', {'newP': newBid});
                      //   print('emmited');
                      // }else{
                      //
                      // }
                  }, (value){newBid = int.parse(value);}, currentBid+5000));
                },
                child: Text('Bid ', style: !isDisabled ?TextStyle(backgroundColor: Colors.blue, color: Colors.amberAccent): TextStyle(backgroundColor: Colors.grey),),
                ),
              ],
            ),
            // TextButton(onPressed: (){
            //
            // }, child: Text('Add Comment')),
            SingleChildScrollView(
              child: Column(
                children: comments == null || comments.length == 0?
                [Text('No Comments for this post')] :
                comments.map((comment)=>CommentCard(comment)).toList()
              ),
            )
            ],
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
