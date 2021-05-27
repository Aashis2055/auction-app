import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart';

class DetailScreen extends StatefulWidget {
  static final String id = "detail_screen";
  final String v_id;
  DetailScreen(this.v_id);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Socket socket;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  void setUp() {
    try {
      socket = io('http://192.168.10.69:5000', <String, dynamic>{
        'transport': ['websocket'],
        'autoConnect': false
      });
      socket.onconnect();
      socket.onConnect((data) {
        Fluttertoast.showToast(msg: 'socket connected');
      });
      socket.on('bid', bid);
    } catch (e) {
      Fluttertoast.showToast(msg: "error on socket");
    }
  }

  void bid(dynamic data) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('details'),
      ),
      body: Container(
        child: Column(
          children: [Icon(Icons.access_time_sharp), Text("Model")],
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
