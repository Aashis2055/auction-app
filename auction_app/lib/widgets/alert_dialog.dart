import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String message;
  MyAlertDialog(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Error', style: TextStyle(color: Colors.red),),
        content: Text(this.message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
