import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String img;
  final int price;
  final String model;
  final String color;
  final String type;
  final Function callback;
  static const height = 360.0;
  MyCard({this.img,this.model, this.color, this.price, this.type, this.callback});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Column(
            children: [
              Image.asset(img),
              Text(price.toString()),
              Text(model),
              Text(color)
            ],
          ),
          onTap: callback,
          splashColor: Colors.blue,
        ),
      ),
    );
  }
}
