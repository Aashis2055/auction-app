import 'package:flutter/material.dart';
class AlertTextField extends StatelessWidget {
  final String title;
  final Function cahangeEvent;
  final Function callback;
  final int suggestBid;
  AlertTextField(this.title, this.callback, this.cahangeEvent, this.suggestBid);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        
        onChanged: (value){
          
        },
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