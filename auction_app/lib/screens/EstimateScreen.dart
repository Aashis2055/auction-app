import 'package:flutter/material.dart';

class EstimateScreen extends StatefulWidget {
  static final String id = "estimate_screen";

  @override
  _EstimateScreenState createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is the estimate screen"),
    );
  }
}