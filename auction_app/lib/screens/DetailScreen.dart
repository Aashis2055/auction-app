import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [Icon(Icons.access_time_sharp), Text("Model")],
        ),
      ),
    );
  }
}
