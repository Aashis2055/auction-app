import 'package:flutter/material.dart';
import 'package:auction_app/models/notification.dart';
class SoldScreen extends StatelessWidget {
  final NotificationModel notification;
  SoldScreen(this.notification);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: notification.type == "Sold"?Text('Vehicle Sold') : Text('Vehicle Bought')),
      body: Container(
        child: Text(notification.message)
      ),
    );
  }
}