import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FilterBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Fluttertoast.showToast(msg: 'filtered');
              },
              child: Text('Filter'))
        ],
      ),
    );
  }
}
