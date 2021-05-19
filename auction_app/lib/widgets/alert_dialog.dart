import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  Widget okButton = TextButton(
    child: Text('OK'),
    onPressed: () {
      // TODO something
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Error'),
        content: Text('Check your Internet Connection'),
        actions: [okButton],
      ),
    );
  }
}
