import 'package:auction_app/services/network.dart';
import 'package:flutter/material.dart';
// models
import 'package:auction_app/models/notification.dart';
// widget
import 'package:auction_app/widgets/NotificationTile.dart';

class NotificationFrag extends StatefulWidget {
  @override
  _NotificationFragState createState() => _NotificationFragState();
}

class _NotificationFragState extends State<NotificationFrag> {
  NetworkHelper networkHelper;
  List<NotificationModel> notification;
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    await networkHelper.initState();
    List<NotificationModel> myNotifications =
        await networkHelper.getNotifications();
    if (myNotifications == null) {
      return;
    } else {
      setState(() {
        notification = myNotifications;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView.builder(
      itemBuilder: (builder, index) {
        return NotificationTile(notification[index]);
      },
    ));
  }
}
