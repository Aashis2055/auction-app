import 'package:flutter/material.dart';
class AlertTextField extends StatelessWidget {
  final String title;
  final Function changeEvent;
  final Function callback;
  final int suggestBid;
  AlertTextField(this.title, this.callback, this.changeEvent, this.suggestBid);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        onChanged: changeEvent,
      ),
      actions: [
        TextButton(onPressed: (){
          callback();
          Navigator.pop(context);
        }, child: Text('OK')),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'))
      ],
    );
  }
}