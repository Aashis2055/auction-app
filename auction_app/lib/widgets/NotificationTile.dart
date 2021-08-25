import 'package:auction_app/screens/Sold.dart';
import 'package:flutter/material.dart';
// model
import 'package:auction_app/models/notification.dart';
import 'package:auction_app/utils/notification-text.dart';
// 
class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final String message;
  NotificationTile(this.notification, this.message);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(getNotificationText(notification)),
      trailing: notification.type == "Sold" || notification.type == "Bought" ? TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SoldScreen(notification)));
      }, 
      child: Text('Details')): null,
    );
  }
}
