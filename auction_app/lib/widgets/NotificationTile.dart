import 'package:flutter/material.dart';
// model
import 'package:auction_app/models/notification.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  NotificationTile(this.notification);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.message),
      trailing: Text(notification.date),
    );
  }
}
