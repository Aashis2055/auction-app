import 'package:flutter/material.dart';
class SoldScreen extends StatelessWidget {
  final String type;
  SoldScreen(this.type);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: this.type == "Sold"?Text('Vahicle Sold') : Text('Vehicle Bought')),
      body: Container(
        child: this.type == 'Sold'?
        Text('congratulation you have sold your Vehicle'):
        Text('congratulation you have bought a Vehicle')
      ),
    );
  }
}