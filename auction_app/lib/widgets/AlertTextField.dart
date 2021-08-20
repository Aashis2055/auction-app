import 'package:flutter/material.dart';
class AlertTextField extends StatelessWidget {
  final String title;
  final Function cahangeEvent;
  final Function callback;
  AlertTextField(this.title, this.callback, this.cahangeEvent);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        onChanged: cahangeEvent,
      ),
      actions: [
        TextButton(onPressed: callback, child: Text('OK')),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'))
      ],
    );
  }
}